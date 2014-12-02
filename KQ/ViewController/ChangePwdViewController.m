//
//  ChangePwdViewController.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "TextfieldCell.h"

@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
     _config = [[TableConfiguration alloc] initWithResource:@"ChangePwdConfig"];
    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(10, 33, _w-20, 34) title:@"提交" bgImageName:nil target:self action:@selector(submitPressed:)];
    btn.backgroundColor = kColorYellow;
    btn.layer.cornerRadius = 3;
    btn.titleLabel.font = [UIFont fontWithName:kFontBoldName size:15];
    _submitBtn = btn;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 120;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 100)];
    
    [v addSubview:_submitBtn];
    
    return v;
    
}


- (void)initConfigCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    UITextField *tf = (UITextField*)cell.subView;
    tf.secureTextEntry = YES;
    
    if ([cell.key isEqualToString:@"oldPwd"]) {
        tf.placeholder = @"当前密码";

    }
    else if ([cell.key isEqualToString:@"newPwd"]) {
        tf.placeholder = @"新密码(6-23位)";
    }
    else if ([cell.key isEqualToString:@"newPwd2"]) {
        tf.placeholder = @"重复输入新密码";
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
}

#pragma mark - IBAction

- (IBAction)submitPressed:(id)sender{

    for (ConfigCell* cell in self.tableView.visibleCells) {
//        NSLog(@"key # %@,value # %@",cell.key,cell.value);
        
        if ([cell.key isEqualToString:@"oldPwd"]) {
            self.oldPwd = cell.value;
        }
        else if([cell.key isEqualToString:@"newPwd"]){
            self.nPwd = cell.value;
        }
        else if([cell.key isEqualToString:@"newPwd2"]){
            self.nPwd2 = cell.value;
        }
    }

    
    [self validateWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
//            [self willConnect:sender];
            
            
            [self changePwd:self.oldPwd newPwd:self.nPwd];
        }
        else{
            [ErrorManager alertError:error];
        }
    }];

}

#pragma mark - Fcns

- (void)validateWithBlock:(BooleanResultBlock)block{
    
    CustomErrorCode code = 0;
    
    if (ISEMPTY(self.oldPwd) || ISEMPTY(self.nPwd) || ISEMPTY(self.nPwd2)) {
        code = ErrorAppEmptyParameter;
    }
    else if(![self.nPwd isEqualToString:self.nPwd2]){
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
- (void)changePwd:(NSString*)oldPwd newPwd:(NSString*)newPwd{

    
    [self willLoad:_submitBtn];
    [_userController changePwd:oldPwd newPwd:newPwd boolBlock:^(BOOL succeeded, NSError *error) {
        
        [self willStopLoad];
        if (succeeded && _networkFlag) {
            [_libraryManager startHint:@"密码修改成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    }];
}

@end
