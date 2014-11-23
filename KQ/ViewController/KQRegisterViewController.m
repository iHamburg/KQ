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
//
//#pragma mark - Alert
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//
//    [[NetworkClient sharedInstance] user:[[UserController sharedInstance] uid] downloadCoupon:kEventCouponId block:^(id obj, NSError *error) {
//     
//        if (obj) {
//            
////            [_libraryManager startHint:@"下载快券成功"];
//
//            NSLog(@"下载快券成功");
//        }
//        
//    }];
//    
//    [self toAfterDownload];
//}
//
//#pragma mark - Fcn
//
//
//- (void)toAgreement{
//    
//    AgreementViewController *vc = [[AgreementViewController alloc]init];
//    vc.title = @"快券注册协议";
//    
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)requestCaptcha{
//    NSString *mobile = _userTextField.text;
//    
//    //    NSLog(@"request mobile # %@",mobile);
//    
//    [self willConnect:_identifyB];
//    [[NetworkClient sharedInstance] requestCaptchaRegister:mobile block:^(NSDictionary* object, NSError *error) {
//        
//        if (!error) {
//            NSString *captcha = object[@"captcha"];
//            //            NSLog(@"captcha # %@",captcha);
//            
//            self.captcha = captcha;
//        }
//        else{
//            [ErrorManager alertError:error];
//        }
//        
//        [self willDisconnect];
//    }];
//}
//
//-(IBAction)signUpUserPressed:(id)sender
//{
//    
//    ///  先进行validate， 通过后再注册
//    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//   
//            NSDictionary *info = @{@"username":self.userTextField.text,@"password":[_passwordTextField.text stringWithMD5]};
//            
//            //    NSLog(@"info # %@",info);
//            
//            [self registerUser:info];
//        }
//        else{
//            NSString *msg = [error localizedDescription];
//            [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
//        }
//    }];
//
//    
//}
//
//- (void)validateWithBlock:(BooleanResultBlock)block{
//
//    CustomErrorCode code = 0;
//    
////    NSString *msg = @"请输入所有信息";
//    NSString *inputedCaptcha = _verifyTextField.text;
//    
//    if (ISEMPTY(_userTextField.text) || ISEMPTY(_passwordTextField.text)) {
//    // 如果用户名或密码为空
//
//        code = ErrorAppEmptyParameter;
//
//        
//    }
//    else if(![self.captcha isEqualToString:[inputedCaptcha stringWithMD5]]){
//        
//        
//        code = ErrorAppInvalidCaptcha;
//    }
//    
//    if (code == 0) {
//        block(YES,nil);
//    }
//    else{
//        
//        NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: code]}];
//        
//        block(NO,error);
//    }
//}
//
//// pw 已经是md5
//- (void)registerUser:(NSDictionary *)userInfo{
//
//    [self willConnect:_registerB];
//    [[UserController sharedInstance] registerWithUserInfo:userInfo block:^(BOOL succeeded, NSError *error) {
//        
//        
//        if (succeeded && self.networkFlag) {
//            // 如果注册成功， login 一下获得用户的咨询
//            NSString *username = userInfo[@"username"];
//            NSString *password = userInfo[@"password"];
//            
//            [[UserController sharedInstance] loginWithUsername:username password:password boolBlock:^(BOOL succeeded, NSError *error) {
//            
//            }];
//            
//            
//            /// 注册成功后显示提示窗
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"已获免费摩提快券，请前往绑定银行卡" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//        }
//        
//        [self willDisconnect];
//    }];
//
//    
//}

//- (void)toAfterDownload{
//    
//    AfterDownloadViewController *vc = [[AfterDownloadViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}



@end
