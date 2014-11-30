//
//  KQRegisterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRegisterViewController.h"
#import "UserController.h"
#import "WebViewController.h"
#import "AfterDownloadViewController.h"
#import "NetworkClient.h"
#import "NSString+md5.h"

@interface KQRegisterViewController ()

@end

@implementation KQRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userTextField.placeholder = @"手机号";


     self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
