//
//  ChangePasswordViewController.h
//  KQ
//
//  Created by Forest on 14-9-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SignViewController.h"

@interface ChangePasswordViewController : SignViewController{
     UITextField *_passwordTextField, *_rePasswordTextField;

}

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
