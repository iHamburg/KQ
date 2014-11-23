//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"
#import "ErrorManager.h"
#import "UserController.h"
#import "WebViewController.h"
#import "AfterDownloadViewController.h"
#import "NetworkClient.h"
#import "NSString+md5.h"

@interface RegisterViewController (){
    
      
}

@end

@implementation RegisterViewController

#define kCellHeight 44.0

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.title = @"注册";
    
    self.view.backgroundColor = kColorBG;

    
    _tableImageNames = @[@"icon-user.png",@"icon-identifying.png",@"icon-password01.png",@"icon-password02.png"];
    
    CGFloat x = 60;
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _userTextField.keyboardType = UIKeyboardTypeNumberPad;
    _userTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _userTextField.placeholder = @"手机号(11位)";
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 180, kCellHeight)];
    _verifyTextField.placeholder = @"手机验证码";
    _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _passwordTextField.placeholder = @"密码(至少6位)";
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    

    _rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _rePasswordTextField.placeholder = @"密码(至少6位)";
    _rePasswordTextField.secureTextEntry = YES;
    _rePasswordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    _tfs = @[_userTextField,_verifyTextField,_passwordTextField,_rePasswordTextField];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 250) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    
    CGFloat y = CGRectGetMaxY(_tableView.frame);
    
    //TODO: 可以用TogoleBtn refactor
    _selected = YES;
    _selectBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 30, 30) title:nil bgImageName:@"icon-agreement03.png" target:self action:@selector(selectAgreementClicked:)];

    _readL = [[UILabel alloc] initWithFrame:CGRectMake(45, y, 100, 30)];
    _readL.text = @"我已阅读并同意";
    _readL.textColor = kColorDardGray;
    _readL.font = [UIFont fontWithName:kFontName size:14];
    _readL.userInteractionEnabled = YES;
    [_readL addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(selectAgreementClicked:)]];
    
    _agreementB = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_readL.frame), y, 120, 30) title:@"《快券注册协议》" bgImageName:nil target:self action:@selector(agreementClicked:)];
    [_agreementB setTitleColor:kColorBlue forState:UIControlStateNormal];
    _agreementB.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    _agreementB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    
    _registerB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_selectBtn.frame) + 10 , 300, 40) title:@"注册" bgImageName:nil target:self action:@selector(signUpUserPressed:)];
    [_registerB.titleLabel setFont:[UIFont fontWithName:kFontBoldName size:18]];
    _registerB.layer.cornerRadius = 3;
    _registerB.backgroundColor = kColorRed;

    
    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_selectBtn];
    [_scrollView addSubview:_readL];
    [_scrollView addSubview:_agreementB];
    [_scrollView addSubview:_registerB];


    _scrollView.contentSize = CGSizeMake(0, 668);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1.0;
    }
    else{
        return 20;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 55;
    }
    else
        return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int section  = (int)indexPath.section;
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    //
    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
    
    if (section == 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
        imgV.image = [UIImage imageNamed:@"register_banner.jpg"];
        [cell addSubview:imgV];
    }
    else{
        cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];

      

        if (indexPath.row == 1) {
            _identifyB = (CaptchaButton*)[CaptchaButton buttonWithFrame:CGRectMake(230, 3, 90, kCellHeight - 6) title:@"获取验证码" bgImageName:nil target:self action:@selector(identifyClicked:)];
            
            [_identifyB setTitleColor:kColorYellow forState:UIControlStateNormal];
            [_identifyB.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
            
            UIView *borderV = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identifyB.frame)-1, 5,1,kCellHeight-10)];
            borderV.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
            
            [cell.contentView addSubview:_identifyB];
            [cell.contentView addSubview:borderV];
        }
        
        
        
          [cell.contentView addSubview:_tfs[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   
    
   
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}

#pragma mark - IBAction
- (IBAction)selectAgreementClicked:(id)sender{
    L();
    
    if (_selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement01.png"] forState:UIControlStateNormal];
    }
    else{
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement03.png"] forState:UIControlStateNormal];
    }
    
    _selected = !_selected;
}

- (IBAction)agreementClicked:(id)sender{
//    L();
    [self toAgreement];
}


- (IBAction)identifyClicked:(id)sender{
    L();
    [_identifyB startTimer];
    [self requestCaptcha];
}
#pragma mark - Private methods

//- (void)requestCaptcha{
//
//}
//
//-(IBAction)signUpUserPressed:(id)sender
//{
//
//   
//}
//
//
//- (void)toAgreement{
//    
//}
//
//- (void)registerUser:(NSDictionary *)userInfo{
//
//}
//
//- (void)validateWithBlock:(BooleanResultBlock)block{
//}


#pragma mark - Alert
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
//    [[NetworkClient sharedInstance] user:[[UserController sharedInstance] uid] downloadCoupon:kEventCouponId block:^(id obj, NSError *error) {
//        
//        if (obj) {
//            
//            //            [_libraryManager startHint:@"下载快券成功"];
//            
//            NSLog(@"下载快券成功");
//        }
//        
//    }];
    
    self.successBlock(YES,nil);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark - Fcn



-(IBAction)signUpUserPressed:(id)sender
{
    
    ///  先进行validate， 通过后再注册
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            NSDictionary *info = @{@"username":self.userTextField.text,@"password":[_passwordTextField.text stringWithMD5]};
            
            //    NSLog(@"info # %@",info);
            
            [self registerUser:info];
        }
        else{
            NSString *msg = [error localizedDescription];
            [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
        }
    }];
    
    
}

- (void)validateWithBlock:(BooleanResultBlock)block{
    
    CustomErrorCode code = 0;
    
    //    NSString *msg = @"请输入所有信息";
    NSString *inputedCaptcha = _verifyTextField.text;
    
    if (ISEMPTY(_userTextField.text) || ISEMPTY(_passwordTextField.text)) {
        // 如果用户名或密码为空
        
        code = ErrorAppEmptyParameter;
        
        
    }
    else if(![self.captcha isEqualToString:[inputedCaptcha stringWithMD5]]){
        
        
        code = ErrorAppInvalidCaptcha;
    }
    
    if (code == 0) {
        block(YES,nil);
    }
    else{
        
        NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: code]}];
        
        block(NO,error);
    }
}


- (void)requestCaptcha{
    NSString *mobile = _userTextField.text;
    
    //    NSLog(@"request mobile # %@",mobile);
    
    //在转验证码的时候,
//    [self willConnect:_identifyB];
    
    
    [_network requestCaptchaRegister:mobile block:^(NSDictionary* object, NSError *error) {
        
//        [self willDisconnect];
//        if (!self.networkFlag) {
//            return;
//        }
        
        if (!error) {
            NSString *captcha = object[@"captcha"];
            //            NSLog(@"captcha # %@",captcha);
            
            self.captcha = captcha;
        }
        else{
            [ErrorManager alertError:error];
            
            [_identifyB stopTimer];
        }
        
        
    }];
}
// pw 已经是md5
- (void)registerUser:(NSDictionary *)userInfo{
    
    [self willConnect:_registerB];
    
    [_userController registerWithUserInfo:userInfo block:^(BOOL succeeded, NSError *error) {
        
        [self willDisconnect];
        
        if (succeeded && self.networkFlag) {
            
            /// 注册成功后显示提示窗
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"已获免费摩提快券，请前往绑定银行卡" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
       
    }];
    
    
}



- (void)toAgreement{
    
    WebViewController *vc = [[WebViewController alloc]init];
    vc.title = @"快券注册协议";
    vc.fileName = @"quickquan_agreement.html";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
