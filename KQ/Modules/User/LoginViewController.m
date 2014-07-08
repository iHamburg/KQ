//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LoginViewController.h"

#import "UserController.h"
#import "KQRootViewController.h"


@interface LoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController



- (void)viewDidLoad{

    [super viewDidLoad];
    
  
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];

    self.navigationItem.leftBarButtonItem = bb;

    self.title = @"用户登录";
    
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 17, 250, 40)];
//    _userTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user.png"]];
//    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    _userTextField.keyboardType = UIKeyboardTypeNumberPad;
    _userTextField.returnKeyType = UIReturnKeyNext;
    _userTextField.placeholder = @"用户名";
    _userTextField.delegate = self;
//    _userTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(_userTextField.frame)+5, 250, 40)];//f
//    _passwordTextField.center = CGPointMake(_w/2, CGRectGetMaxY(_userTextField.frame)+40);
//    _passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password.png"]];
//    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.placeholder = @"密码";
//    _passwordTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    CGFloat y = CGRectGetMaxY(_passwordTextField.frame) ;
    
    _loginB = [UIButton buttonWithFrame:CGRectMake(30, y, 120, 40) title:LString(@"登录") bgImageName:nil target:self action:@selector(loginPressed:)];
    _loginB.backgroundColor = kColorYellow;
    _loginB.titleLabel.font = [UIFont fontWithName:FONTNAME size:20];
    
    
//    _registerB = [UIButton buttonWithFrame:CGRectMake(170, y, 120, 40) title:@"注册" bgImageName:nil target:self action:@selector(registerPressed:)];
//    _registerB.titleLabel.font = [UIFont fontWithName:FONTNAME size:20];
//    _registerB.backgroundColor = kColorYellow;
    
    [self.view addSubview:_userTextField];
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_loginB];
//    [self.view addSubview:_registerB];
    
    self.view.backgroundColor = kColorWhite;
    
   

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_userTextField becomeFirstResponder];
}

#pragma mark - IBAction

-(IBAction)loginPressed:(id)sender
{
 
    [self loginWithEmail:_userTextField.text password:_passwordTextField.text];
}


- (IBAction)registerPressed:(id)sender{

    [self toRegister];
}

- (IBAction)forgetPressed:(id)sender{

    
    [self enterForget];
}

#pragma mark - Fcns

- (void)loginWithEmail:(NSString*)email password:(NSString *)password{
    
    [[UserController sharedInstance] loginWithEmail:email pw:password block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self close];
            [[KQRootViewController sharedInstance] didLogin];
        }
    }];
}


- (void)enterForget{

}


- (IBAction)backPressed:(id)sender{
    
    [self close];
}

- (void)toRegister{
    
}

- (void)close{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
