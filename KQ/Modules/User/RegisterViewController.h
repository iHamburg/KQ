//
//  RegisterViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignViewController.h"

@interface RegisterViewController : SignViewController<UIAlertViewDelegate>{


    IBOutlet UIButton *_registerB;
    IBOutlet UIButton  *_identifyB;

    IBOutlet UITextField *_userTextField,*_passwordTextField, *_verifyTextField, *_rePasswordTextField;
    
    UIButton *_selectBtn,*_agreementB;
    UILabel *_readL;
    BOOL _selected;

}

@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) NSString *captcha;  // 从server端获得的md5密文


- (IBAction)signUpUserPressed:(id)sender;
- (IBAction)identifyClicked:(id)sender;

- (void)toAgreement;
- (void)requestCaptcha;
- (void)registerUser:(NSDictionary*)userInfo;
- (void)validateWithBlock:(BooleanResultBlock)block;

@end
