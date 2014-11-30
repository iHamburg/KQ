//
//  EditUserViewController.h
//  KQ
//
//  Created by Forest on 14-11-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"

@interface EditUserViewController : ConfigViewController<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    UIActionSheet *_editAvatarAction;
    UIAlertView *_editUsernameAlert;
    UIAlertView *_logoutAlert;
}

@property (nonatomic, strong) People *people;

- (IBAction)editAvatarPressed:(id)sender;
- (IBAction)editUsernamePressed:(id)sender;
- (IBAction)editPasswordPressed:(id)sender;
- (IBAction)logoutPressed:(id)sender;

- (void)actionEditAvatar;
- (void)alertEditUsername;
- (void)alertLogout;

- (void)pushEditPassword;
- (void)openCamera;
- (void)openImageLibrary;
- (void)logout;
- (void)changeUserName:(NSString*)newName;
@end
