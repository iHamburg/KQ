//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController (){
    
      
}

@end

@implementation RegisterViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"用户注册";
    
    self.view.backgroundColor = kColorBG;

    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    
    _bgV = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 306, 182)];
    _bgV.image = [UIImage imageNamed:@"register_tf_bg.jpg"];
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 12, 260, 40)];
//    _userTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user.png"]];
//    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    _userTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _userTextField.placeholder = @"用户名";
    _userTextField.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:0.5];
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 142, 260, 40)];
    _passwordTextField.placeholder = @"密码(至少6位)";
    _passwordTextField.secureTextEntry = YES;
//    _passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password.png"]];
//    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:0.5];
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 56, 212, 40)];
    _verifyTextField.placeholder = @"验证码(测试版不用输入)";
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 102, 212, 40)];
    _usernameTextField.placeholder = @"昵称";
    
    _registerB = [UIButton buttonWithFrame:CGRectMake(7, 210 , 306, 40) title:@"注册" bgImageName:nil target:self action:@selector(signUpUserPressed:)];
    [_registerB.titleLabel setFont:[UIFont fontWithName:kFontName size:15]];
    _registerB.backgroundColor = kColorRed;

    [scrollView addSubview:_bgV];
    [scrollView addSubview:_userTextField];
    [scrollView addSubview:_passwordTextField];
    [scrollView addSubview:_verifyTextField];
    [scrollView addSubview:_usernameTextField];
    [scrollView addSubview:_registerB];


    scrollView.contentSize = CGSizeMake(0, 568);
    
    [self.view addSubview:scrollView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - Private methods

-(IBAction)signUpUserPressed:(id)sender
{

   
}

- (IBAction)agreementPressed:(id)sender{

}

- (void)registerUser:(NSDictionary *)userInfo{

}

- (void)validateWithBlock:(BooleanResultBlock)block{
}
@end
