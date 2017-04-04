# [sh8.email](http://sh8.email/) iOS

[sh8.email](http://sh8.email/) is an anonymous, silent, and secure email service. This is an iOS native app for sh8.email.

## Index

1. Implemented Features
2. Dependencies
3. Installation
4. Contribution Guideline
5. Upcoming Features

## Features

- [x] Can receive and view plain email
- [x] Can receive and view locked email

## Dependencies

sh8.email depends on several packages from [CocoaPods](https://cocoapods.org/), a dependency manager for Swift and Objective-C Cocoa projects:
- [Alamofire](https://github.com/Alamofire/Alamofire) for networking
- [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) to automatically convert Alamofire's JSON response data into Swift objects
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper/)
- [Kanna](https://github.com/tid-kijyun/Kanna) to parse HTML of email contents
- [KeenClient]() to collect analytics

## Installation

1. Install CocoaPods dependencies:
 ```
 $ pod install
 ```

## Contribution Guideline

Please report bugs, issues, suggestions for improvement under [Issues](https://github.com/triplepy/sh8email-ios/issues).

## Upcoming Features

- [ ] Launches Safari on tapping external links in email content view
