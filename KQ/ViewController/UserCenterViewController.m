//
//  UserCenterViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCouponsViewController.h"
#import "UserShopsViewController.h"
#import "UserCardsViewController.h"
#import "UserSettingsViewController.h"
#import "UIImageView+WebCache.h"
#import "KQRootViewController.h"
#import "UserFavoritedCouponsViewController.h"
#import "EditUserViewController.h"
#import "AboutUsViewController.h"
#import "UserNewsViewController.h"

#define headerHeight 150

#pragma mark - Cell: UserAvatar
@interface UserAvatarCell : ConfigCell{

}

@property (nonatomic, strong) IBOutlet UIImageView *oberV;
@property (nonatomic, strong) IBOutlet UILabel *dCouponNumLabel;
@property (nonatomic, strong) IBOutlet UILabel *cardNumLabel;
@property (nonatomic, strong) IBOutlet UIButton *dCouponNumBtn;
@property (nonatomic, strong) IBOutlet UIButton *cardNumBtn;
@property (nonatomic, copy) VoidBlock editUserBlock;
@property (nonatomic, copy) VoidBlock dCouponBlock;
@property (nonatomic, copy) VoidBlock cardBlock;
@property (nonatomic, copy) VoidBlock loginBlock;

- (IBAction)loginPressed:(id)sender;
- (IBAction)dCouponPressed:(id)sender;
- (IBAction)cardPressed:(id)sender;


@end

@implementation UserAvatarCell


- (void)setValue:(People *)people{
//    L();
 
    _value = people;
//    [super setPeople:people];
    
    if (!people) {
        
        self.oberV.image = [UIImage imageNamed:@"userAvatarUnLogin.jpg"];
        self.avatarV.hidden = YES;
        self.dCouponNumLabel.text = @"0";
        self.cardNumLabel.text = @"0";
    }
    else{
        self.avatarV.hidden = NO;
        self.dCouponNumLabel.text = [NSString stringWithFormat:@"%d",people.dCouponNum];
        self.cardNumLabel.text = [NSString stringWithFormat:@"%d",people.cardNum];
    }
    
    if (ISEMPTY(people.avatarUrl)) {

        self.avatarV.image = DefaultImg;
    }

    else{
         [self.avatarV setImageWithURL:[NSURL URLWithString:people.avatarUrl] placeholderImage:DefaultImg];
    }
    self.firstLabel.text = people.nickname;
   
}

//height: 150


- (void)load{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarV.layer.cornerRadius = 60;
    self.avatarV.layer.masksToBounds = YES;
    self.avatarV.layer.borderWidth = 8;
    self.avatarV.layer.borderColor = [UIColor whiteColor].CGColor;
    
 
    
    self.oberV.userInteractionEnabled = YES;
    [self.oberV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginPressed:)]];
    
    //在nib中，imageV不能拖成另一个imageV的subview，所以只能在code中设置
    [self.oberV addSubview:self.avatarV];
    
    // 针对ios7！
//    if (isIOS7Only) {
//        [self addSubview:self.oberV];
//        [self addSubview:self.dCouponNumBtn];
//        [self addSubview:self.cardNumBtn];
//
//    }

    [self.contentView removeFromSuperview];
}


#pragma mark - IBAction
- (IBAction)loginPressed:(id)sender{
    
    UserController *uc = [UserController sharedInstance];
 
    if ([uc isLogin]) {
        self.editUserBlock();
    }
    else{
        self.loginBlock();
    }
}
- (IBAction)dCouponPressed:(id)sender{
    
    
    UserController *uc = [UserController sharedInstance];
    
    if ([uc isLogin]) {
        self.dCouponBlock();
    }
    else{
        self.loginBlock();
    }
}
- (IBAction)cardPressed:(id)sender{

    UserController *uc = [UserController sharedInstance];
    
    if ([uc isLogin]) {
        self.cardBlock();
    }
    else{
        self.loginBlock();
    }

}


@end
#pragma mark -
#pragma mark - UserCenterViewController

@interface UserCenterViewController (){

    UserAvatarCell *_avatarCell;
}

@end

@implementation UserCenterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCenterLoginConfig"];
//    _config = [[TableConfiguration alloc] initWithResource:@"UserCenterConfig"];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();
    
//    [_networkClient queryUserInfo:_userController.uid sessionToken:_userController.sessionToken block:^(NSDictionary* dict, NSError *error) {
//        
//        if (!error) {
//            // 如果没有出错
//            NSLog(@"dict # %@",dict);
//            
//        }
//        else{
//            int code = error.code;
//            
//            if (code == ErrorInvalidSession){
//                // 如果是session过期，logout
//            
//                [_userController logout];
//
//               
//            }
//            else{
//                [ErrorManager alertError:error];
//            }
//        }
//        
//    }];

    
    // 刷一次avatarCell, ConfigVC会刷的！
//    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
//        return headerHeight;
        return 1;
    }
    return 20;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];
//        v.backgroundColor = kColorBlue;
//        
//        return v;
//    }
//    
//    return nil;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    return nil;
//}


- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[UserAvatarCell class]]) {
        UserAvatarCell *aCell = (UserAvatarCell*)cell;
     
        
        aCell.editUserBlock = ^(void){
            [self pushEditUser];
        };
        
        aCell.dCouponBlock = ^(void){
            [self toCoupons];
        };
        
        aCell.cardBlock = ^(void){
            [self toCards];
        };
        aCell.loginBlock = ^{
            [self presentLogin];
        };
    }

    if (indexPath.section > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

}

// 反正没太大的关系，可以多次调用
- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"cell # %@",cell);
    int section = indexPath.section;
    int row = indexPath.row;
    
    if ([cell isKindOfClass:[UserAvatarCell class]]) {
        UserAvatarCell *aCell = (UserAvatarCell*)cell;
        
        [aCell setValue:_userController.people];

    }
    
    if (section == 1) {
        if (row == 0) {
            // fCoupon
            int num = _userController.people.fCouponNum;
            cell.value = [NSString stringWithInt:num];
        }
        else{
            // fShop
            int num = _userController.people.fShopNum;
            cell.value = [NSString stringWithInt:num];
        }
    }
    
}


#pragma mark - IBAction
- (IBAction)dCouponPressed:(id)sender{
    if ([_userController isLogin]) {
        [self toCoupons];
    }
    else{
        [self presentLogin];
    }

}
- (IBAction)cardPressed:(id)sender{
    if ([_userController isLogin]) {
        [self toCards];
    }
    else{
        [self presentLogin];
    }

}
- (IBAction)fCouponPressed:(id)sender{
    if ([_userController isLogin]) {
        [self toFavoritedCoupons];
    }
    else{
        [self presentLogin];
    }

}
- (IBAction)fShopPressed:(id)sender{
    if ([_userController isLogin]) {
        [self toShops];
    }
    else{
        [self presentLogin];
    }

}
- (IBAction)aboutUsPressed:(id)sender{
    [self pushAboutUs];
}

- (IBAction)newsPressed:(id)sender{
    
    if ([_userController isLogin]) {
        [self pushNews];
    }
    else{
        [self presentLogin];
    }
    
}
- (IBAction)settingPressed:(id)sender{
    
    if ([_userController isLogin]) {
        [self toSettings];
    }
    else{
        [self presentLogin];
    }
    
}

#pragma mark - Fcns


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

    
    
    UserFavoritedCouponsViewController *vc = [[UserFavoritedCouponsViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toSettings{

    UserSettingsViewController *vc = [[UserSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)pushEditUser{
    
    EditUserViewController *vc = [[EditUserViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushNews{
    
    UserNewsViewController *vc = [[UserNewsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushAboutUs{
    AboutUsViewController *vc = [[AboutUsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentLogin{
    
    KQRootViewController *root = [KQRootViewController sharedInstance];
    
    [root presentLoginWithMode:PresentUserCenterLogin];
}

@end
