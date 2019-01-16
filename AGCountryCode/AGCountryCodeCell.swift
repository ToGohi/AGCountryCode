//
//  AGCountryCodeCell.swift
//  demo
//
//  Created by Antonio González Hidalgo on 16/01/2019.
//  Copyright © 2019 Antonio Gonzalez Hidalgo. All rights reserved.
//

import UIKit

class AGCountryCodeCell: UIView {

    //MARK: - IBOutlets
    @IBOutlet weak var countryImage:        UIImageView!
    @IBOutlet weak var countryTitle:        UILabel!
    @IBOutlet weak var countryCode:         UILabel!
    
    //MARK: - UIView methods
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupCountryPickerCell()
    }
    
    //MARK: - Inits
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCountryPickerCell()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCountryPickerCell()
    }
    
    //MARK: - Public methods
    
    func setupCell(country:Country) {
        countryTitle.text = country.name
        countryCode.text = country.dial_code
        countryImage.image = country.flag
    }
    
    //MARK: - Private methods
    
    private func setupCountryPickerCell() {
        if let contentView = loadViewFromNib() {
            addSubview(contentView)
        }
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AGCountryCodeCell", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return view
        }
        return nil
    }

}
