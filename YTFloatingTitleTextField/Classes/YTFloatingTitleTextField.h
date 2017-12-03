//
//  YTFloatingTitleTextField.h
//  YTFloatingTitleTextField
//
//  Created by chantil on 12/03/2017.
//

#import <UIKit/UIKit.h>

@interface YTFloatingTitleTextField : UITextField

typedef NS_ENUM(NSUInteger, YTFloatingTitleTextFieldStatus) {
    YTFloatingTitleTextFieldStatusNormal = 0,
    YTFloatingTitleTextFieldStatusError = 1
};

@property (nonatomic, assign) YTFloatingTitleTextFieldStatus status;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *normalTextFont;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *normalLineColor;

@property (nonatomic, strong) UIFont *errorTextFont;
@property (nonatomic, strong) UIColor *errorTextColor;
@property (nonatomic, strong) UIColor *errorLineColor;

@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, assign) UIEdgeInsets titleInsets;
@property (nonatomic, assign) UIEdgeInsets placeholderInsets;

@end
