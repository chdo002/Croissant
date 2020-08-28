# Croissant

[![CI Status](https://img.shields.io/travis/chdo002/Croissant.svg?style=flat)](https://travis-ci.org/chdo002/Croissant)
[![Version](https://img.shields.io/cocoapods/v/Croissant.svg?style=flat)](https://cocoapods.org/pods/Croissant)
[![License](https://img.shields.io/cocoapods/l/Croissant.svg?style=flat)](https://cocoapods.org/pods/Croissant)
[![Platform](https://img.shields.io/cocoapods/p/Croissant.svg?style=flat)](https://cocoapods.org/pods/Croissant)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Croissant is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CDCroissant'
```

## Understanding Croissant Architecture

`Croissant`: receive `CRInspector` messages, and send to  `CRServer`

`CRInspector`:   observe printing and network tracffic

`CRServer` :   webserver, socket provider

## Author

chdo002, 1107661983@qq.com

## License

Croissant is available under the MIT license. See the LICENSE file for more info.
