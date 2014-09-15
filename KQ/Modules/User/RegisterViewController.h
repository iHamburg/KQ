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
    IBOutlet UITextField *_userTextField;
    IBOutlet UITextField *_passwordTextField, *_verifyTextField, *_usernameTextField, *_rePasswordTextField;
    
    UIButton *_selectBtn,*_agreementB;
    UILabel *_readL;
    BOOL _selected;

}

@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;


- (IBAction)signUpUserPressed:(id)sender;
- (IBAction)identifyClicked:(id)sender;

- (void)toAgreement;

- (void)registerUser:(NSDictionary*)userInfo;
- (void)validateWithBlock:(BooleanResultBlock)block;

@end
