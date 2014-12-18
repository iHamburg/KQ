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
    _passwordTextField.returnKeyType = UIReturnKeySend;
    _passwordTextField.delegate = self;

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
    _selectBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 30, 30) title:nil imageName:@"icon-agreement03.png" target:self action:@selector(selectAgreementClicked:)];

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
        return 65;
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


        UIImageView *leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 12, 40, 40)];
        leftImgV.image = [UIImage imageNamed:@"register_events_icon_image.png"];
        
        UIImageView *rightV = [[UIImageView alloc] initWithFrame:CGRectMake(272, 0, 48, 65)];
        rightV.image = [UIImage imageNamed:@"register_events_right.png"];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 175, 65)];
        label.text = @"只要注册快券，就可以1元获得原价18元的美味摩提哦";
        label.numberOfLines = 0;
        label.textColor = kColorYellow;
        label.font = bFont(13);
        
        [cell addSubview:leftImgV];
        [cell addSubview:rightV];
        [cell addSubview:label];
    
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


#pragma mark - Textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _passwordTextField) {
        [self signUpUserPressed:textField];
    }
    
    return YES;
}

#pragma mark - IBAction
- (IBAction)selectAgreementClicked:(id)sender{
    L();
    
    if (_selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon-agreement01.png"] forState:UIControlStateNormal];
//        [_selectBtn setImage:[UIImage imageNamed:@"icon_white_back.png"] forState:UIControlStateNormal];
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




#pragma mark - Alert

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    
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
//          [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
            
            [_libraryMng startHint:msg];
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
    else if(!_selected){
    
        code = ErrorAppUnselected;
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
    _userTextField.userInteractionEnabled = NO;
    _userTextField.textColor = kColorLightGray;
    
    [_network requestCaptchaRegister:mobile block:^(NSDictionary* object, NSError *error) {

        
        if (!error) {
            NSString *captcha = object[@"captcha"];
            //            NSLog(@"captcha # %@",captcha);
            
            self.captcha = captcha;
            [_libraryMng startHint:@"验证码已发送"];
        }
        else{
            [ErrorManager alertError:error];
            
            _userTextField.userInteractionEnabled = YES;
            _userTextField.textColor = kColorBlack;
            
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"前往领取免费美味摩提快券" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
