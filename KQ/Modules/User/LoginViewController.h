//
//  LoginViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    UIScrollView *_scrollView;
    
    IBOutlet UITextField* _userTextField;
    IBOutlet UITextField *_passwordTextField;


    IBOutlet UIButton *_loginB;
    IBOutlet UIButton *_forgetB;
    IBOutlet UIButton *_registerB;
    

    UITableView *_tableView;
    
    NSArray *_tfs, *_tableImageNames;
    
}

- (IBAction)loginPressed:(id)sender;
- (IBAction)registerPressed:(id)sender;
- (IBAction)forgetPressed:(id)sender;

- (void)loginWithEmail:(NSString*)email password:(NSString *)password;

- (void)toRegister;
- (void)toForget;
@end
