# STPUAllocationTracker

[![CI Status](http://img.shields.io/travis/Stefan Puehringer/STPUAllocationTracker.svg?style=flat)](https://travis-ci.org/Stefan Puehringer/STPUAllocationTracker)
[![Version](https://img.shields.io/cocoapods/v/STPUAllocationTracker.svg?style=flat)](http://cocoapods.org/pods/STPUAllocationTracker)
[![License](https://img.shields.io/cocoapods/l/STPUAllocationTracker.svg?style=flat)](http://cocoapods.org/pods/STPUAllocationTracker)
[![Platform](https://img.shields.io/cocoapods/p/STPUAllocationTracker.svg?style=flat)](http://cocoapods.org/pods/STPUAllocationTracker)

## Installation

STPUAllocationTracker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "STPUAllocationTracker"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To use this library, there is no configuration or import needed at all, everything gets loaded automatically. Simply run your app and whenever the app is brought to the background or gets terminated, a snapshot with the count of the currently living objects is saved to the documents folder.

The information in this folder can be used to spot leaks and other memory-issues at any stage of the development-process, but is **NOT** intended to be used in a live application.

## Acknowledgment

This library is based heavily on the ideas and code-samples shared in [this blogpost](https://code.facebook.com/posts/1146930688654547) by Facebook.

## Author

Stefan Puehringer, me@stefanpuehringer.com

## License

STPUAllocationTracker is available under the MIT license. See the LICENSE file for more info.
