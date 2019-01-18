# AGCountryCode

[![Build Status](https://travis-ci.com/ToGohi/AGCountryCode.svg?branch=master)](https://travis-ci.com/ToGohi/AGCountryCode)
[![Version](https://img.shields.io/cocoapods/v/AGCountryCode.svg?style=flat)](https://cocoapods.org/pods/AGCountryCode)
[![License](https://img.shields.io/cocoapods/l/AGCountryCode.svg?style=flat)](https://cocoapods.org/pods/AGCountryCode)
[![Platform](https://img.shields.io/cocoapods/p/AGCountryCode.svg?style=flat)](https://cocoapods.org/pods/AGCountryCode)

## Installation

AGCustomControls is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AGCountryCode'
```

## Description

A custom UIPickerView to provide to the user a list of countries.

## To use

To create a view to show the country picker

```ruby
    let countryView = AGCountryCodeView()
```
The CountryPickerViewDelegate notificates when user selects a country

```ruby
public protocol AGCountryCodeViewDelegate {
    
    /// Every time the user selects a country, the delegate will call this function.
    ///
    /// - Parameters:
    ///   - view: Sender (AGCountryCodeView)
    ///   - countryName: The name of the country selected
    ///   - countryCode: The code of the country selected
    ///   - countryDialCode: The dial code of the country selected
    ///   - flag: The flag of the country selected
    func countryPickerSelectedCountry(view: AGCountryCodeView,
                                      countryName:String?,
                                      countryCode:String?,
                                      countryDialCode:String?,
                                      flag:UIImage?)
}
```

## Screenshots

![GitHub Logo](https://github.com/ToGohi/AGCountryCode/raw/master/screen01.png)
![GitHub Logo](https://github.com/ToGohi/AGCountryCode/raw/master/screen02.png)

## Author

Antonio González, togohi@gmail.com

## License

AGCountryCode is available under the MIT license. See the LICENSE file for more info.
