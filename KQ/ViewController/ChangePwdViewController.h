//
//  ChangePwdViewController.h
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"

@interface ChangePwdViewController : ConfigViewController

@property (nonatomic, strong) NSString *oldPwd;
@property (nonatomic, strong) NSString *nPwd;
@property (nonatomic, strong) NSString *nPwd2;

- (IBAction)submitPressed:(id)sender;

- (void)validateWithBlock:(BooleanResultBlock)block;
- (void)changePwd:(NSString*)oldPwd newPwd:(NSString*)newPwd;
@end
