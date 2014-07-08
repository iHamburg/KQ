//
//  KQRegisterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRegisterViewController.h"
#import "UserController.h"

@interface KQRegisterViewController ()

@end

@implementation KQRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userTextField.placeholder = @"手机号";

     _userTextField.keyboardType = UIKeyboardTypeNumberPad;

    _verifyTextField.userInteractionEnabled = NO;
     self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(IBAction)signUpUserPressed:(id)sender
{
    
 
    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSDictionary *info = @{@"username":self.userTextField.text,@"password":_passwordTextField.text,@"phone":_userTextField.text,
                                   @"nickname":_usernameTextField.text};
            
            //    NSLog(@"info # %@",info);
            
            [self registerUser:info];
        }
    }];

    
}

- (void)validateWithBlock:(BooleanResultBlock)block{

      NSString *msg = @"请输入所有信息";
    if (ISEMPTY(_userTextField.text) || ISEMPTY(_passwordTextField.text) || ISEMPTY(_usernameTextField.text)) {
        [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
        block(NO,nil);
        
    }
    else{
        block(YES,nil);
    }

    
}

- (void)registerUser:(NSDictionary *)userInfo{

    
    [[UserController sharedInstance] registerWithUserInfo:userInfo block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];

    
}


@end
