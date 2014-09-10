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


@interface LoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController



- (void)viewDidLoad{

    [super viewDidLoad];
    
  
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];

    self.navigationItem.leftBarButtonItem = bb;

    self.title = @"用户登录";
    
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 17, 250, 40)];
    _userTextField.keyboardType = UIKeyboardTypeNumberPad;
    _userTextField.returnKeyType = UIReturnKeyNext;
    _userTextField.placeholder = @"用户名";
    _userTextField.delegate = self;
    _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _userTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
//    _userTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user.png"]];
//    _userTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(_userTextField.frame)+5, 250, 40)];//f

    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    
    
//    [self.view addSubview:_userTextField];
//    [self.view addSubview:_passwordTextField];
//    [self.view addSubview:_registerB];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, 2000);

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 88 + 70) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    
    _loginB = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_tableView.frame) , 300, 40) title:LString(@"登录") bgImageName:nil target:self action:@selector(loginPressed:)];
    _loginB.backgroundColor = kColorYellow;
    _loginB.titleLabel.font = [UIFont fontWithName:FONTNAME size:10];
    _loginB.layer.cornerRadius = 3;
    
    CGFloat y = CGRectGetMaxY(_loginB.frame) + 10;
    _registerB = [UIButton buttonWithFrame:CGRectMake(10, y, 100, 30) title:@"注册" bgImageName:nil target:self action:@selector(toRegister)];
    
    
    _forgetB = [UIButton buttonWithFrame:CGRectMake(200, y, 100, 30) title:@"忘记密码？" bgImageName:nil target:self action:@selector(toForget)];
    
    
    [_scrollView addSubview:_loginB];
    [_scrollView addSubview:_registerB];
    [_scrollView addSubview:_forgetB];
    [_scrollView addSubview:_tableView];
   

    [self.view addSubview:_scrollView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_userTextField becomeFirstResponder];
}

#pragma mark - IBAction

-(IBAction)loginPressed:(id)sender
{
 
    [self loginWithEmail:_userTextField.text password:_passwordTextField.text];
}


- (IBAction)registerPressed:(id)sender{

    [self toRegister];
}

- (IBAction)forgetPressed:(id)sender{

    
    [self toForget];
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
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    
    //!!!: 可以根据Setting的不同进行不同的工作
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
//        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:16];
//        cell.detailTextLabel.font = [UIFont fontWithName:FONTNAME size:16];
        
        [cell.contentView addSubview:_userTextField];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"icon-user.png"];
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    
}

#pragma mark - Fcns

- (void)loginWithEmail:(NSString*)email password:(NSString *)password{
    
    [[UserController sharedInstance] loginWithEmail:email pw:password block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
        
            [self close];
            
            [[KQRootViewController sharedInstance] didLogin];
        
        }
    }];
}


//- (void)enterForget{
//
//}


- (IBAction)backPressed:(id)sender{
    
    [self close];
}

- (void)toRegister{
    
}

- (void)toForget{
    
}

- (void)close{
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
