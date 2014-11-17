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
#import "EditUserViewController.h"
#import "AboutUsViewController.h"
#import "UserNewsViewController.h"

#define headerHeight 150

#pragma mark - Cell: UserAvatar
@interface UserAvatarCell : PeopleCell{

}

@property (nonatomic, strong) IBOutlet UIImageView *oberV;
@property (nonatomic, copy) VoidBlock editUserBlock;
@property (nonatomic, copy) VoidBlock dCouponBlock;
@property (nonatomic, copy) VoidBlock cardBlock;
@property (nonatomic, copy) VoidBlock loginBlock;

- (IBAction)loginPressed:(id)sender;
- (IBAction)dCouponPressed:(id)sender;
- (IBAction)cardPressed:(id)sender;



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

//height: 150

- (void)awakeFromNib{
    
    L();
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarV.layer.cornerRadius = 60;
    self.avatarV.layer.masksToBounds = YES;
    self.avatarV.layer.borderWidth = 8;
    self.avatarV.layer.borderColor = [UIColor whiteColor].CGColor;

    self.backgroundColor = kColorBG;
    self.separatorInset = UIEdgeInsetsMake(0, 160, 0, 160);
    
    self.oberV.userInteractionEnabled = YES;
    [self.oberV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginPressed:)]];
    
    //在nib中，imageV不能拖成另一个imageV的subview，所以只能在code中设置
    [self.oberV addSubview:self.avatarV];
}



// 需要判断用户是否登录来切换UI
- (void)layoutSubviews{
    L();
    [super layoutSubviews];
    
    // 如果是ios7
    [self addSubview:self.oberV];
    
//    NSLog(@"subviews # %@",self.subviews);
    
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
    
    self.dCouponBlock();
}
- (IBAction)cardPressed:(id)sender{

    self.cardBlock();
}


@end
#pragma mark -
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
    
   // _config = [[TableConfiguration alloc] initWithResource:@"UserCenterLoginConfig"];
    _config = [[TableConfiguration alloc] initWithResource:@"UserCenterLoginConfig"];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();
    
    ///如果用户登录，使用不同的UI （UserAvaterCell）, 现在可以直接刷新table来让cell更新？
    if ([_userController isLogin]) {
        
    }
    else{
        
    }

    [self.tableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
//
//    if ([cell isKindOfClass:[PeopleCell class]]) {
//        [(PeopleCell*)cell setPeople:_userController.people];
//    }
//    
//    if (indexPath.section == 1) {
//        
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
//    }
//
//}


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

// 反正没太大的关系，可以多次调用
- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[PeopleCell class]]) {
        UserAvatarCell *aCell = (UserAvatarCell*)cell;
        [aCell setPeople:_userController.people];

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

    
    
    UserFavoritedCouponsViewController *vc = [[UserFavoritedCouponsViewController alloc] init];
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
