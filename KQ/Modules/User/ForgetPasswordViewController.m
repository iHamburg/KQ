//
//  ForgetPasswordViewController.m
//  KQ
//
//  Created by Forest on 14-9-11.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "ErrorManager.h"
#import "NSString+md5.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

#define kCellHeight 44.0
/*
 
 UserCase 忘记密码
 
  用户输入手机号
  用户点击获取验证码
     客户端从服务器获得captcha1
     用户从手机获得captcha1
  用户输入从手机获得的captcha
  用户提交
  系统比较用户输入的captcha和captcha1，如果一致的话，进入修改密码，如果不一致则提示用户
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    
     _tableImageNames = @[@"icon-user.png",@"icon-identifying.png"];
    
    CGFloat x = 60;
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _userTextField.keyboardType = UIKeyboardTypeNumberPad;
    _userTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _userTextField.placeholder = @"请输入手机号码";
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 180, kCellHeight)];
    _verifyTextField.placeholder = @"请输入短信验证码";
    
    _tfs = @[_userTextField,_verifyTextField];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 150) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;

    _submitBtn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_tableView.frame) + 10 , 300, 40) title:@"提交" bgImageName:nil target:self action:@selector(submitClicked:)];
    [_submitBtn.titleLabel setFont:[UIFont fontWithName:kFontBoldName size:18]];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = kColorRed;

    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_submitBtn];
    
     _scrollView.contentSize = CGSizeMake(0, 600);
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        
        [cell.contentView addSubview:_tfs[indexPath.row]];
    }
    
    if (indexPath.row == 1) {
        _identifyB = [UIButton buttonWithFrame:CGRectMake(230, 3, 90, kCellHeight - 6) title:@"获取验证码" bgImageName:nil target:self action:@selector(identifyClicked:)];
        
        [_identifyB setTitleColor:kColorYellow forState:UIControlStateNormal];
        [_identifyB.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
        
        UIView *borderV = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_identifyB.frame)-1, 5,1,kCellHeight-10)];
        borderV.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
        
        [cell.contentView addSubview:_identifyB];
        [cell.contentView addSubview:borderV];

    }
    
    cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
}




#pragma mark - IBAction

- (IBAction)identifyClicked:(id)sender{
    L();

    [self requestCaptcha];
}


- (IBAction)submit{
    L();
    
    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.username = _userTextField.text;
            [self toChangePwd];
        }
        else{
            NSString *msg = [error localizedDescription];
            [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
        }
    }];
}

#pragma mark - Fcn


- (void)validateWithBlock:(BooleanResultBlock)block{
    
    int code = 0;
    
     NSString *inputedCaptcha = _verifyTextField.text;
    
    //TODO: reset
    if (ISEMPTY(_verifyTextField.text) || ISEMPTY(_userTextField.text)) {
        // 如果用户名或密码为空
        
        code = ErrorAppEmptyParameter;
    }
//    else if (![[inputedCaptcha stringWithMD5] isEqualToString:self.captcha]) {
//        // 验证码不一致
//        
//        code = ErrorAppInvalidCaptcha;
//    }
    
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
    
    [self willConnect:_identifyB];
    [[NetworkClient sharedInstance] requestCaptchaForgetPassword:mobile block:^(NSDictionary* object, NSError *error) {
        
        [self willDisconnect];
        
        if (!self.networkFlag) {
            return;
        }
        
        if (!error) {
            
            NSString *captcha = object[@"captcha"];
            self.captcha = captcha;
        }
        else {
            [ErrorManager alertError:error];
        }
    }];
}



- (void)toChangePwd{
    
    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
    vc.username = self.username;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
