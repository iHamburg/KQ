//
//  UserCenterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCenterViewController.h"
#import "PeopleCell.h"
#import "UserCouponsViewController.h"
#import "UserShopsViewController.h"
#import "UserCardsViewController.h"
#import "UserSettingsViewController.h"
#import "UIImageView+WebCache.h"
#import "KQRootViewController.h"
#import "UserFavoritedCouponsViewController.h"

#pragma mark - Cell: UserAvatar
@interface UserAvatarCell : PeopleCell<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation UserAvatarCell


- (void)setPeople:(People *)people{
    L();
    [super setPeople:people];
    
    if (ISEMPTY(people.avatarUrl)) {

        self.avatarV.image = DefaultImg;
    }

    else{
         [self.avatarV setImageWithURL:[NSURL URLWithString:people.avatarUrl] placeholderImage:DefaultImg];
    }
//

    self.firstLabel.text = people.nickname;


   
}

//height: 190


- (void)awakeFromNib{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarV.layer.cornerRadius = 60;
    self.avatarV.layer.masksToBounds = YES;
    self.avatarV.layer.borderWidth = 8;
    self.avatarV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarV.userInteractionEnabled = YES;
    [self.avatarV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarVPressed:)]];
    
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarVPressed:)]];
    self.backgroundColor = kColorBG;
    self.separatorInset = UIEdgeInsetsMake(0, 160, 0, 160);
    

}

- (IBAction)avatarVPressed:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:LString(@"取消") destructiveButtonTitle:LString(@"照相机") otherButtonTitles:LString(@"图片库"), nil];//f
    
    [sheet showInView:self];
}

- (void)layoutSubviews{
    
    
}
#pragma mark - Actionsheet
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

    
    
    // save image to currentuser.avatar
  
    [[UserController sharedInstance] setAvatar:img200];

    //???: 为什么不能直接变设avatar？
    
    [self performSelector:@selector(imagePickerControllerDidCancel:) withObject:picker afterDelay:1];
//    [self imagePickerControllerDidCancel:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    L();
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Fcns


- (void)openImageLibrary{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [[KQRootViewController sharedInstance] presentViewController:picker animated:YES completion:^{
        
    }];
    
//    [RootInstance presentModalViewController:picker animated:YES];
    
}


- (void)openCamera{
    L();
    
    /// 显示 camera
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    [[KQRootViewController sharedInstance] presentViewController:picker animated:YES completion:^{
        
    }];
    
}

@end

#pragma mark - UserCenterViewController

@interface UserCenterViewController (){


}

@end

@implementation UserCenterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCenterLoginConfig"];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();

}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    if ([cell isKindOfClass:[PeopleCell class]]) {
        [(PeopleCell*)cell setPeople:_userController.people];
    }
    
    if (indexPath.section == 1) {
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section !=0) {
        return 20;
    }
    return 1;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    L();
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - AlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    NSLog(@"button # %d",buttonIndex);
    
    if (buttonIndex == 1) {
        [self willLogout];
    }
}

#pragma mark - IBAction

- (IBAction)logout{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要退出当前账号吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    
    [alert show];
    
    
    
}

#pragma mark - Fcns


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

- (void)toCoupons{

    
    UserCouponsViewController *vc = [[UserCouponsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toShops{

    
    UserShopsViewController *vc = [[UserShopsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toCards{

    UserCardsViewController *vc = [[UserCardsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toFavoritedCoupons{

    
    
    UserFavoritedCouponsViewController *vc = [[UserFavoritedCouponsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toSettings{

    UserSettingsViewController *vc = [[UserSettingsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)willLogout{
    
    [_userController logout];

    
    [[KQRootViewController sharedInstance] didLogout];
}

- (void)didLogin{

    //???: 什么时候调用？
    [self.tableView reloadData];
    
}
@end
