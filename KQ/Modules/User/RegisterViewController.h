//
//  RegisterViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{

   IBOutlet UIScrollView *scrollView;
   IBOutlet    UIImageView *_bgV;

    IBOutlet UIButton *_registerB;
    IBOutlet UIButton *_agreementB, *_identifyB;
    IBOutlet UITextField *_userTextField;
    IBOutlet UITextField *_passwordTextField, *_verifyTextField, *_usernameTextField;

    UITextField *_rePasswordTextField;

}

@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;


- (IBAction)signUpUserPressed:(id)sender;
- (IBAction)agreementPressed:(id)sender;
- (void)registerUser:(NSDictionary*)userInfo;
- (void)validateWithBlock:(BooleanResultBlock)block;

@end
