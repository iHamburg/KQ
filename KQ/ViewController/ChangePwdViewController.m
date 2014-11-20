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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            [self changePwd:self.oldPwd newPwd:self.nPwd];
        }
        else{
            [ErrorManager alertError:error];
        }
    }];

}

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
    
    [_userController changePwd:oldPwd newPwd:newPwd boolBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [_libraryManager startHint:@"密码修改成功"];
        }
    }];
}

@end
