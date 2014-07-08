//
//  KQLoginViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQLoginViewController.h"
#import "KQRegisterViewController.h"
@interface KQLoginViewController ()

@end

@implementation KQLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _userTextField.placeholder = @"手机号";
    _loginB.frame = CGRectMake(10, 120, 300, 40);
    [_loginB setBackgroundColor:kColorRed];
    
    self.title = @"登录快券";
  
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = kColorBG;
 }

- (void)viewDidAppear:(BOOL)animated{
    L();
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toRegister{
    L();
//    RegisterViewController *vc = [[KQRegisterViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];

//    [self performSegueWithIdentifier:@"toRegister" sender:nil];
}


@end
