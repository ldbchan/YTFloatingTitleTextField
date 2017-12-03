//
//  YTFloatingTitleTextField.m
//  YTFloatingTitleTextField
//
//  Created by chantil on 12/03/2017.
//

#import "YTFloatingTitleTextField.h"

typedef NS_ENUM(NSUInteger, HintLabelMode) {
    HintLabelModeTitle = 0,
    HintLabelModePlaceholder = 1,
};

@interface YTFloatingTitleTextField ()

@property (nonatomic, assign) HintLabelMode hintLabelMode;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) NSString *alternativePlaceholder;
@property (nonatomic, strong) NSLayoutConstraint *hintLabelTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *hintLabelBottomConstraint;

@end

@implementation YTFloatingTitleTextField

#pragma mark - Loading From Nib

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];

    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addTarget:self action:@selector(textEditingDidChange) forControlEvents:UIControlEventEditingChanged];

    [self addHintLabel];
    [self addBottomLine];

    [self configure];
    [self updateHintLabel];
    [self updateBottomLine];
    [self updateText];
}

- (void)addBottomLine {
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.userInteractionEnabled = NO;
    self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bottomLine];

    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomLine]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"bottomLine": self.bottomLine}];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottomMargin
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.bottomLine attribute:NSLayoutAttributeBottomMargin
                                                                       multiplier:1 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1 constant:1.5];
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:hConstraints];
    [constraints addObject:bottomConstraint];
    [constraints addObject:heightConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)addHintLabel {
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.userInteractionEnabled = NO;
    self.hintLabel.textAlignment = self.textAlignment;
    self.hintLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.hintLabel];

    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|"
                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                                                    metrics:nil
                                                                      views:@{@"titleLabel": self.hintLabel}];
    self.hintLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.hintLabel attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self attribute:NSLayoutAttributeTop
                                                              multiplier:1 constant:0];
    self.hintLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.hintLabel attribute:NSLayoutAttributeBottom
                                                                 multiplier:1 constant:0];
    self.hintLabelBottomConstraint.priority = 750;

    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObjectsFromArray:hConstraints];
    [constraints addObject:self.hintLabelTopConstraint];
    [constraints addObject:self.hintLabelBottomConstraint];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configure {
    _status = YTFloatingTitleTextFieldStatusNormal;

    if (super.placeholder) {
        _title = super.placeholder;
    }
    _titleFont = [self.font fontWithSize:13];
    _titleColor = [UIColor darkTextColor];

    if (super.placeholder) {
        _alternativePlaceholder = super.placeholder;
    }
    _placeholderFont = self.font;
    _placeholderColor = [UIColor lightGrayColor];

    _normalTextFont = self.font;
    _normalTextColor = self.textColor;
    _normalLineColor = self.textColor;

    _errorTextFont = self.font;
    _errorTextColor = [UIColor redColor];
    _errorLineColor = [UIColor redColor];

    CGFloat height = CGRectGetHeight(self.bounds);
    _titleInsets = UIEdgeInsetsMake(0.15 * height, 0, 0.6 * height, 0);
    _textInsets = UIEdgeInsetsMake(0.5 * height, 0, 0.15 * height, 0);
    _placeholderInsets = UIEdgeInsetsMake(0.15 * height, 0, 0.15 * height, 0);

    super.placeholder = nil;
}

#pragma mark - Setter

- (void)setText:(NSString *)text {
    [super setText:text];
    [self updateHintLabel];
}

- (void)setFont:(UIFont *)font {
    _normalTextFont = font;
    [self updateText];
}

- (void)setTextColor:(UIColor *)textColor {
    _normalTextColor = textColor;
    [self updateText];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.hintLabel.textAlignment = textAlignment;
}

- (void)setStatus:(YTFloatingTitleTextFieldStatus)status {
    _status = status;
    [self updateBottomLine];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self updateHintLabel];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [self updateHintLabel];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self updateHintLabel];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _alternativePlaceholder = placeholder;
    [self updateHintLabel];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self updateHintLabel];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updateHintLabel];
}

- (void)setNormalTextFont:(UIFont *)normalTextFont {
    _normalTextFont = normalTextFont;
    [self updateText];
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    _normalTextColor = normalTextColor;
    [self updateText];
}

- (void)setNormalLineColor:(UIColor *)normalLineColor {
    _normalLineColor = normalLineColor;
    [self updateBottomLine];
}

- (void)setErrorTextFont:(UIFont *)errorTextFont {
    _errorTextFont = errorTextFont;
    [self updateText];
}

- (void)setErrorTextColor:(UIColor *)errorTextColor {
    _errorTextColor = errorTextColor;
    [self updateText];
}

- (void)setErrorLineColor:(UIColor *)errorLineColor {
    _errorLineColor = errorLineColor;
    [self updateBottomLine];
}

- (void)setTitleInsets:(UIEdgeInsets)titleInsets {
    _titleInsets = titleInsets;
    [self updateHintLabel];
}

- (void)setPlaceholderInsets:(UIEdgeInsets)placeholderInsets {
    _placeholderInsets = placeholderInsets;
    [self updateHintLabel];
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
    [self setNeedsLayout];
}

#pragma mark - Getter

- (NSString *)placeholder {
    return _alternativePlaceholder;
}

- (HintLabelMode)hintLabelMode {
    return self.text.length ? HintLabelModeTitle : HintLabelModePlaceholder;
}

#pragma mark - Text Editing Observer

- (void)textEditingDidChange {
    [self updateHintLabel];
}

#pragma mark - UITextField Override Method

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [self calculatedTextRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self calculatedTextRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return [self calculatedTextRectForBounds:bounds];
}

#pragma mark - Private Method

- (CGRect)calculatedTextRectForBounds:(CGRect)bounds {
    switch (self.hintLabelMode) {
        case HintLabelModeTitle:
            return UIEdgeInsetsInsetRect(bounds, self.textInsets);
        case HintLabelModePlaceholder:
            return UIEdgeInsetsInsetRect(bounds, self.placeholderInsets);
    }
}

- (void)updateHintLabel {
    switch (self.hintLabelMode) {
        case HintLabelModeTitle: {
            self.hintLabel.text = self.title;
            self.hintLabel.font = self.titleFont;
            self.hintLabel.textColor = self.titleColor;
            self.hintLabelTopConstraint.constant = self.titleInsets.top;
            self.hintLabelBottomConstraint.constant = self.titleInsets.bottom;
            break;
        }
        case HintLabelModePlaceholder: {
            self.hintLabel.text = self.placeholder;
            self.hintLabel.font = self.placeholderFont;
            self.hintLabel.textColor = self.placeholderColor;
            self.hintLabelTopConstraint.constant = self.placeholderInsets.top;
            self.hintLabelBottomConstraint.constant = self.placeholderInsets.bottom;
            break;
        }
    }
}

- (void)updateBottomLine {
    switch (self.status) {
        case YTFloatingTitleTextFieldStatusNormal:
            self.bottomLine.backgroundColor = self.normalLineColor;
            break;
        case YTFloatingTitleTextFieldStatusError:
            self.bottomLine.backgroundColor = self.errorLineColor;
            break;
    }
}

- (void)updateText {
    switch (self.status) {
        case YTFloatingTitleTextFieldStatusNormal: {
            super.font = self.normalTextFont;
            super.textColor = self.normalTextColor;
            break;
        }
        case YTFloatingTitleTextFieldStatusError: {
            super.font = self.errorTextFont;
            super.textColor = self.errorTextColor;
            break;
        }
    }
}

@end
