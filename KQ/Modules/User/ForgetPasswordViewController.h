//
//  ForgetPasswordViewController.h
//  KQ
//
//  Created by Forest on 14-9-11.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SignViewController.h"

@interface ForgetPasswordViewController : SignViewController{
    
    IBOutlet UITextField* _userTextField, *_verifyTextField;

    UIButton *_identifyB;

    NSString *_username, *_captcha1;

}



@end
