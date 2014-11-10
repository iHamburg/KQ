//
//  LoginViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignViewController.h"

@interface LoginViewController : SignViewController{
    
    
    IBOutlet UITextField* _userTextField;
    IBOutlet UITextField *_passwordTextField;


    IBOutlet UIButton *_loginB;
    IBOutlet UIButton *_forgetB;
    IBOutlet UIButton *_registerB;
    
    
}

- (IBAction)loginPressed:(id)sender;
- (IBAction)registerPressed:(id)sender;
- (IBAction)forgetPressed:(id)sender;

- (void)loginWithEmail:(NSString*)email password:(NSString *)password;

- (void)toRegister;
- (void)toForget;

@end
