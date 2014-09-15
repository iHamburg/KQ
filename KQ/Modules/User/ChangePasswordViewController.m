//
//  ChangePasswordViewController.m
//  KQ
//
//  Created by Forest on 14-9-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

#define kCellHeight 44.0


/**
 Use Case 修改密码
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置密码";
    
    self.view.backgroundColor = kColorBG;
    
    
    _tableImageNames = @[@"icon-password01.png",@"icon-password02.png"];
    
    CGFloat x = 60;
       _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _passwordTextField.placeholder = @"新密码(至少6位)";
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    _rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _rePasswordTextField.placeholder = @"重复输入密码";
    _rePasswordTextField.secureTextEntry = YES;
    _rePasswordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _tfs = @[_passwordTextField,_rePasswordTextField];
    
    
    //    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 102, 212, 40)];
    //    _usernameTextField.placeholder = @"昵称";
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 160) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    
    CGFloat y = CGRectGetMaxY(_tableView.frame);
   
    
    _submitBtn = [UIButton buttonWithFrame:CGRectMake(10, y + 10 , 300, 40) title:@"提交" bgImageName:nil target:self action:@selector(submitClicked:)];
    [_submitBtn.titleLabel setFont:[UIFont fontWithName:kFontBoldName size:18]];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = kColorRed;
    
    
    [_scrollView addSubview:_tableView];
    [_scrollView addSubview:_submitBtn];
    
    
    _scrollView.contentSize = CGSizeMake(0, 668);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    //
    
    //!!!: 可以根据Setting的不同进行不同的工作
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];

        cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];
        
        [cell.contentView addSubview:_tfs[indexPath.row]];
        
    
    
    
    
    

    return cell;
    
}

#pragma mark - Fcns

- (void)submit{
    L();
}
@end
