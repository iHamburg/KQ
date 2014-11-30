//
//  ChangePasswordViewController.m
//  KQ
//
//  Created by Forest on 14-9-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UserController.h"
#import "NSString+md5.h"
#import "KQRootViewController.h"

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
    _passwordTextField.delegate = self;
    _passwordTextField.returnKeyType = UIReturnKeyNext;
    
    
    _rePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, 250, kCellHeight)];
    _rePasswordTextField.placeholder = @"重复输入密码";
    _rePasswordTextField.secureTextEntry = YES;
    _rePasswordTextField.autocorrectionType =UITextAutocorrectionTypeNo;
    _rePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _rePasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _rePasswordTextField.delegate = self;
    _rePasswordTextField.returnKeyType = UIReturnKeySend;
    
    _tfs = @[_passwordTextField,_rePasswordTextField];
    
 
    
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
    
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];

        cell.imageView.image = [UIImage imageNamed:_tableImageNames[indexPath.row]];
        
        [cell.contentView addSubview:_tfs[indexPath.row]];
        
   
    return cell;
    
}

#pragma mark - TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _passwordTextField) {
        [_rePasswordTextField becomeFirstResponder];
    }
    else{
        [self submitClicked:textField];
    }
    
    return YES;
}

#pragma mark - Fcns

- (IBAction)submitClicked:(id)sender{
    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.password = _passwordTextField.text;
            [self submit];
        }
        else{
            NSString *msg = [error localizedDescription];
//            [UIAlertView showAlert:msg msg:nil cancel:@"OK"];
             [_libraryMng startHint:msg];
        }
    }];
    
    
}

- (void)validateWithBlock:(BooleanResultBlock)block{
    
    int code = 0;
    
    if (ISEMPTY(_rePasswordTextField.text) || ISEMPTY(_passwordTextField.text)) {
        // 如果用户名或密码为空
        
        code = ErrorAppEmptyParameter;
    }
    else if(![_passwordTextField.text isEqualToString:_rePasswordTextField.text]){

        code = ErrorAppPasswordInConsistent;
    }
   
    
    if (code == 0) {
        block(YES,nil);
    }
    else{

        NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: code]}];

        block(NO,error);
    }
  
}


// 发送请求，重置成功也是login的
- (void)submit{

    L();
    
    [self willConnect:_submitBtn];
    
    __weak ChangePasswordViewController *vc = self;
    [_network user:self.username resetPassword:[self.password stringWithMD5] block:^(NSDictionary *dict, NSError *error) {
        [vc willDisconnect];
        
        if (!vc.networkFlag) {
            return;
        }
        
        if (!error) {
//            NSLog(@"reset successful");
            // 重置成功后，login
            
            [_userController loginWithUsername:vc.username password:[vc.password stringWithMD5] boolBlock:^(BOOL succeeded, NSError *error) {
               
                if (succeeded && vc.networkFlag) {
                    
                    NSLog(@"login successful");
                    
                    vc.successBlock(YES,nil);
                    [vc dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                
                }

                
            }];
            
        }
        else{
             [ErrorManager alertError:error];
        }
    }];
    
}


@end
