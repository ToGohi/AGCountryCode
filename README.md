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
    let countryView = AGCountryCodeView(frame: self.view.bounds)
```
The CountryPickerViewDelegate notificates when user selects a country

```ruby
protocol CountryPickerViewDelegate {
    func countryPickerSelectedCountry(view: AGCountryCodeView,
                                      countryName:String?,
                                      countryCode:String?,
                                      countryDialCode:String?,
                                      flag:UIImage?)
}
```

## Author

Antonio González, togohi@gmail.com

## License

AGCountryCode is available under the MIT license. See the LICENSE file for more info.
