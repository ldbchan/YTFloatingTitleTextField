//
//  ViewController.m
//  YTFloatingTitleTextField
//
//  Created by ldbchan on 12/03/2017.
//  Copyright (c) 2017 ldbchan. All rights reserved.
//

#import "ViewController.h"
#import <YTFloatingTitleTextField/YTFloatingTitleTextField.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldFromIB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YTFloatingTitleTextField *textField = [[YTFloatingTitleTextField alloc] initWithFrame:CGRectMake(40, 150, 200, 60)];
    textField.title = @"Name";
    textField.placeholder = @"What's your name?";
    textField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textField];
}

@end
