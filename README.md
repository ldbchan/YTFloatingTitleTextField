# YTFloatingTitleTextField

[![CI Status](http://img.shields.io/travis/ldbchan/YTFloatingTitleTextField.svg?style=flat)](https://travis-ci.org/ldbchan/YTFloatingTitleTextField) [![Version](https://img.shields.io/cocoapods/v/YTFloatingTitleTextField.svg?style=flat)](http://cocoapods.org/pods/YTFloatingTitleTextField) [![License](https://img.shields.io/cocoapods/l/YTFloatingTitleTextField.svg?style=flat)](http://cocoapods.org/pods/YTFloatingTitleTextField) [![Platform](https://img.shields.io/cocoapods/p/YTFloatingTitleTextField.svg?style=flat)](http://cocoapods.org/pods/YTFloatingTitleTextField)

`YTFloatingTitleTextField` is a subclass of `UITextField` implemented in Objective-C. It is customizable, easy to use, and supported to use programatically or through Interface Builder. Using `YTFloatingTitleTextField` you'll be able to:

- Enable floating title while editing
- Enable showing bottom line
- Use different texts for `title` and `placeholder`
- Use different styles for corresponding status (normal or error)

## Usage

#### Through Interface Builder

- Drag a `UITextField` component into your view controller
- Go to `Identity Inspector > Custom Class` and change the class name to `YTFloatingTitleTextField`

Perks to use Interface Builder -- some default configurations we did for you:

- `title` will be set to be the same as `placeholder`
- `normalTextColor` will be set to be the same as `textColor`
- `normalTextFont` will be set to be the same as `font`
- `normalLineColor` will be set to be the same as `tintColor`

#### In Code

![](https://i.imgur.com/TKBrbk0.gif)

It's also really easy to use in code:

```objc
YTFloatingTitleTextField *textField = [[YTFloatingTitleTextField alloc]
initWithFrame:CGRectMake(40, 150, 200, 60)];
textField.title = @"Name";
textField.placeholder = @"What's your name?";
textField.textAlignment = NSTextAlignmentCenter;
[self.view addSubview:textField];
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 8.0+

## Installation

### CocoaPods

If CocoaPods isn't installed yet, you can do it by running:

```shell
$ gem install cocoapods
```

Then simply add the following line to your Podfile:

```ruby
pod 'YTFloatingTitleTextField'
```

## License

`YTFloatingTitleTextField` is available under the MIT license. See the LICENSE file for more info.
