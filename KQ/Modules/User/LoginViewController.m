//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LoginViewController.h"

#import "UserController.h"
#import "KQRootViewController.h"
#import "ForgetPasswordViewController.h"
#import "NSString+md5.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

#define kCellHeight 44.0

- (void)viewDidLoad{

    [super viewDidLoad];
    
    
    self.title = @"用户登录";

    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 250, kCellHeight)];
    _userTextField.keyboardType = UIKeyboardTypeNumberPad;
    _userTextField.returnKeyType = UIReturnKeyNext;
    _userTextField.placeholder = @"手机号";
    _userTextField.delegate = self;
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userTextField.text = @"13166361023";
    
//    _userTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
//    _userTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user.png"]];
//    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 250, kCellHeight)];//f

    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.text = @"111";
    
    _tfs = @[_userTextField,_passwordTextField];
    _tableImageNames = @[@"icon-user.png",@"icon-password01.png"];
    
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 88 + 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    
    _loginB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_tableView.frame) , 300, 40) title:LString(@"登录") bgImageName:nil target:self action:@selector(loginPressed:)];
    _loginB.backgroundColor = kColorYellow;
    _loginB.titleLabel.font = [UIFont fontWithName:kFontBoldName size:18];
    _loginB.layer.cornerRadius = 3;
    
    CGFloat y = CGRectGetMaxY(_loginB.frame) + 10;
    _registerB = [UIButton buttonWithFrame:CGRectMake(10, y, 100, 30) title:@"注册" bgImageName:nil target:self action:@selector(toRegister)];
    _registerB.titleLabel.font = [UIFont fontWithName:kFontName size:18];
    _registerB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;

    
    _forgetB = [UIButton buttonWithFrame:CGRectMake(210, y, 100, 30) title:@"忘记密码?" bgImageName:nil target:self action:@selector(toForget)];
    _forgetB.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    _forgetB.titleLabel.font = [UIFont fontWithName:kFontName size:18];
    
    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_loginB];
    [_scrollView addSubview:_registerB];
    [_scrollView addSubview:_forgetB];

   

     _scrollView.contentSize = CGSizeMake(0, 600);

    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self test];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
  
}

//-(void)dealloc{
////    L();
//    NSLog(@"dealloc # %@",self);
//}

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
    
    cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

}


#pragma mark - IBAction

-(IBAction)loginPressed:(id)sender
{
    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self loginWithEmail:_userTextField.text password:_passwordTextField.text];
        }
        else{
            NSString *msg = [error localizedDescription];
            [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
        }
    }];
    
    
    //    [self loginWithEmail:_userTextField.text password:_passwordTextField.text];
}


- (IBAction)registerPressed:(id)sender{
    
    [self toRegister];
}

- (IBAction)forgetPressed:(id)sender{
    
    [self toForget];
    
}
#pragma mark - Fcns

- (void)validateWithBlock:(BooleanResultBlock)block{
    
    int code = 0;
    
    if (ISEMPTY(_userTextField.text) || ISEMPTY(_passwordTextField.text)) {
        // 如果用户名或密码为空
        
        code = ErrorAppEmptyParameter;
    }
  
    
    if (code == 0) {
        block(YES,nil);
    }
    else{
        
        NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: code]}];
        
        block(NO,error);
    }
    
}

- (void)loginWithEmail:(NSString*)email password:(NSString *)password{
    
   
    [self willConnect:_loginB];
  
    [_userController loginWithUsername:email password:[password stringWithMD5] boolBlock:^(BOOL succeeded, NSError *error) {
           [self willDisconnect];
        
        if (succeeded && self.networkFlag) {
        
            NSLog(@"login successful");
            PresentMode presentMode = [[KQRootViewController sharedInstance] presentMode];
            
            //登录成功就返回present前的页面
            if (presentMode == PresentUserCenterLogin || presentMode == PresentDefault) {
              
                [[KQRootViewController sharedInstance] dismissNav];
            }
       
        }
     
     

    }];
}




- (void)toRegister{
    
}

- (void)toForget{
    L();
    
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)test{
    
//    _networkFlag = YES;
//    [[NetworkClient sharedInstance] testWithBlock:^(BOOL succeeded, NSError *error) {
//        if (self.networkFlag) {
//            NSLog(@"收到了block的信息 # %@",self);
//        }
//
//    }];
//    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        self.networkFlag = NO;
//    }];
}


@end
