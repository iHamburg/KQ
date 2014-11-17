//
//  EditUserViewController.m
//  KQ
//
//  Created by Forest on 14-11-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "EditUserViewController.h"
#import "ChangePwdViewController.h"

@interface EditUserViewController ()

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    _config = [[TableConfiguration alloc] initWithResource:@"EditUserConfig"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (indexPath.section == 1) {
//        
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
//    }
    
}

#pragma mark - Alert
//改名
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex # %d",buttonIndex);
    if (alertView == _editUsernameAlert && buttonIndex == 1) {
          NSString* string = [[alertView textFieldAtIndex:0] text];
        
        [self changeUserName:string];
    }
    else if(alertView == _logoutAlert && buttonIndex == 1){
        [self logout];
    }
}


#pragma mark - Action
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    //    NSLog(@"button # %d",buttonIndex);
    
    if (buttonIndex == 0) { // destructive: 照相机
        [self openCamera];
    }
    else if(buttonIndex == 1){ //other： 图片库
        [self openImageLibrary];
    }
}

#pragma mark - ImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    L();
    
    /// 存储所有的图片，保存入photoalbum，然后把图片加到album中，一页 3张图
    //    UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //    NSURL *url = info[UIImagePickerControllerMediaURL];
    //    [importImages addObject:originalImage];
    
    
    //avatar 图片的size是200x200 （retina）
    UIImage *img200 = [originalImage imageByScalingAndCroppingForSize:CGSizeMake(100, 100)];
    
    
//    [_userController setAvatar:img200];
    [_userController changeAvatar:img200 boolBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
    
            [_libraryManager startHint:@"头像更换成功！"];
            
            [self.tableView reloadData];
            
        }
        [self imagePickerControllerDidCancel:picker];
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    L();
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - IBAction

- (IBAction)editAvatarPressed:(id)sender{
    [self actionEditAvatar];
}
- (IBAction)editUsernamePressed:(id)sender{
    [self alertEditUsername];
}
- (IBAction)editPasswordPressed:(id)sender{
    [self pushEditPassword];
}
- (IBAction)logoutPressed:(id)sender{
    [self alertLogout];
}

#pragma mark - Fcns

- (void)openImageLibrary{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
//    [[KQRootViewController sharedInstance] presentViewController:picker animated:YES completion:^{
//        
//    }];

    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}


- (void)openCamera{
    L();
    
    /// 显示 camera
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    

    [self presentViewController:picker animated:YES completion:^{
        
    }];
}


- (void)actionEditAvatar{
    
    if (!_editAvatarAction) {
        _editAvatarAction = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相机" otherButtonTitles:@"图片库", nil];
        
    }
    
    [_editAvatarAction showInView:self.view];
}
- (void)alertEditUsername{
    if (!_editUsernameAlert) {
        _editUsernameAlert = [[UIAlertView alloc] initWithTitle:@"修改用户名" message:@"新的用户名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
        _editUsernameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
    }
    
    [_editUsernameAlert show];
}

- (void)alertLogout{
    if (!_logoutAlert) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要退出当前账号吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        
        _logoutAlert = alert;
    }
    
    [_logoutAlert show];
}

- (void)pushEditPassword{
    L();
    ChangePwdViewController *vc = [[ChangePwdViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)logout{
    
    [_userController logout];
    
    //然后退回首页
}
- (void)changeUserName:(NSString*)newName{
    
    [_userController changeNickname:newName boolBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"change nickname successful");
            
            [_libraryManager startHint:@"用户名修改成功！"];
            
            [self.tableView reloadData];
        }
    }];
}
@end
