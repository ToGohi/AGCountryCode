//
//  AGCountryCodeView.swift
//  demo
//
//  Created by Antonio González Hidalgo on 16/01/2019.
//  Copyright © 2019 Antonio Gonzalez Hidalgo. All rights reserved.
//

import UIKit

class Country:Decodable {
    
    var name:String?
    var dial_code:String?
    var code:String?
    var flag: UIImage? {
        guard let _code = code else {
            return nil
        }
        return UIImage(named: _code.lowercased(), in: Bundle(for: AGCountryCodeView.self), compatibleWith: nil)
    }
}

public protocol CountryPickerViewDelegate {
    func countryPickerSelectedCountry(view: AGCountryCodeView,
                                      countryName:String?,
                                      countryCode:String?,
                                      countryDialCode:String?,
                                      flag:UIImage?)
}

public class AGCountryCodeView: UIView {
    
    //MARK: - Constants

    let cellHeight:CGFloat =            30.0

    //MARK: - IBOutlets
    
    @IBOutlet var contentView:          UIView!
    @IBOutlet var tapContentView:       UIView!
    @IBOutlet var pickerContentView:    UIView!
    @IBOutlet var searchFieldTxt:       UITextField!
    @IBOutlet var countryPicker:        UIPickerView!
    
    //MARK: - Private variables
    
    private var fullCountries:          [Country]!
    private var countries:              [Country]!
    private var selectedCountry:        Country? = nil
    
    //MARK: - Public variables
    
    public var countryPickerViewDelegate:CountryPickerViewDelegate?
    
    
    //MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCountryCodeView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCountryCodeView()
    }

    //MARK: - Private methods
    
    private func setupCountryCodeView(){
        
        loadCountries()
        
        if let contentView = loadViewFromNib() {
            addSubview(contentView)
            
            //delegates
            countryPicker.delegate = self
            countryPicker.dataSource = self
            searchFieldTxt.delegate = self
            
            tapContentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeCountryPicker)))
        }
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AGCountryCodeView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return view
        }
        return nil
    }
    
    private func hideKeyboard() {
        searchFieldTxt.resignFirstResponder()
    }
    
    //MARK: - Load data
    
    private func loadCountries() {
        fullCountries = countryNamesByCode()
        countries = countryNamesByCode()
    }
    
    private func countryNamesByCode() -> [Country] {
        
        var countries = [Country]()
        let frameworkBundle = Bundle(for: AGCountryCodeView.self)
        
        guard let jsonPath = frameworkBundle.path(forResource: "Countries", ofType: "json"), let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            return countries
        }
        
        do {
            countries = try JSONDecoder().decode([Country].self, from: jsonData)
        } catch {
            print("Error parsing the countries json")
        }
        return countries
    }
    
    private func selectedCountry(countryCode:String?) -> [Country] {
        guard let country = countryCode else { return fullCountries }
        countries = fullCountries.filter { $0.name!.uppercased().contains(country.uppercased()) }
        return countries.count == 0 ? fullCountries : countries
    }
    
    //MARK: - Actions
    
    @objc private func closeCountryPicker(){
        removeFromSuperview()
    }
}

// MARK: - UIPickerViewDelegate
extension AGCountryCodeView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
        countryPickerViewDelegate?.countryPickerSelectedCountry(view: self,
                                                                countryName: selectedCountry?.name,
                                                                countryCode: selectedCountry?.code,
                                                                countryDialCode: selectedCountry?.dial_code,
                                                                flag: selectedCountry?.flag)
    }

}

// MARK: - UIPickerViewDataSource
extension AGCountryCodeView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let v = view {
            return v
        }else{
            let v = AGCountryCodeCell(frame: CGRect(x: 0, y: 0, width: bounds.width, height: cellHeight))
            v.setupCell(country: countries[row])
            return v
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return cellHeight
    }

    
}

// MARK: - UITextFieldDelegate
extension AGCountryCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var str:String = textField.text!
        str = string == "" ? String(str.dropLast()) : str + string
        countries = selectedCountry(countryCode: str)
        countryPicker.reloadAllComponents()
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        hideKeyboard()
        if countries.count == 1 {
            selectedCountry = countries[0]
        }
        if selectedCountry != nil {
            countryPickerViewDelegate?.countryPickerSelectedCountry(view: self,
                                                                    countryName: selectedCountry?.name,
                                                                    countryCode: selectedCountry?.code,
                                                                    countryDialCode: selectedCountry?.dial_code,
                                                                    flag: selectedCountry?.flag)
            closeCountryPicker()
        }
        return true;
    }
    
}
