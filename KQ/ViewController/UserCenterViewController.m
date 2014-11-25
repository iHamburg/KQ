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
#import "AccessoryLabelCell.h"

#define headerHeight 150

#pragma mark - Cell: UserAvatar
@interface UserAvatarCell : ConfigCell{

}

@property (nonatomic, strong) IBOutlet UIImageView *oberV;
@property (nonatomic, strong) IBOutlet UIImageView *goV;
@property (nonatomic, strong) IBOutlet UILabel *dCouponNumLabel, *dCouponTitleL;
@property (nonatomic, strong) IBOutlet UILabel *cardNumLabel, *cardTitleL;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UILabel *nicknameLabel;
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
 
    _value = people;
    
    if (!people) {
        
        self.oberV.image = [UIImage imageNamed:@"userAvatarUnLogin.jpg"];
        self.avatarV.hidden = YES;
        self.goV.hidden = YES;
        self.dCouponNumLabel.text = @"0";
        self.cardNumLabel.text = @"0";
        self.usernameLabel.text = @"";
        self.nicknameLabel.text = @"";
    }
    else{
        self.oberV.image = [UIImage imageNamed:@"my_header_image.jpg"];
        self.avatarV.hidden = NO;
        self.goV.hidden = NO;
        
        self.dCouponNumLabel.text = [NSString stringWithFormat:@"%d 张",people.dCouponNum];
        self.cardNumLabel.text = [NSString stringWithFormat:@"%d 张",people.cardNum];
        self.usernameLabel.text = people.username;
        self.nicknameLabel.text = people.nickname;
    }
    
    if (ISEMPTY(people.avatarUrl)) {

        self.avatarV.image =  [UIImage imageNamed:@"main_my_avatar.png"];
    }

    else{
         [self.avatarV setImageWithURL:[NSURL URLWithString:people.avatarUrl] placeholderImage: [UIImage imageNamed:@"main_my_avatar.png"]];
    }
    self.firstLabel.text = people.nickname;
   
}

//height: 150


- (void)load{
    
    [self.contentView removeFromSuperview];

    self.avatarV.layer.cornerRadius = 30;
    self.avatarV.layer.masksToBounds = YES;
    self.avatarV.layer.borderWidth = 2;
    self.avatarV.layer.borderColor = [UIColor whiteColor].CGColor;
    
 
    
    self.oberV.userInteractionEnabled = YES;
    [self.oberV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginPressed:)]];
    
    //在nib中，imageV不能拖成另一个imageV的subview，所以只能在code中设置
    [self.oberV addSubview:self.avatarV];
    

    _usernameLabel.font = bFont(15);
    _nicknameLabel.font = bFont(12);
    
    _dCouponNumLabel.font = bFont(12);
    _cardNumLabel.font = bFont(12);
    _cardNumLabel.textColor = kColorGray;
    _dCouponNumLabel.textColor = kColorGray;
    _dCouponTitleL.font = bFont(15);
    _cardTitleL.font = bFont(15);
    _cardTitleL.textColor = kColorBlack;
    _dCouponTitleL.textColor = kColorBlack;

    
    // 垂直分割线
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(160, 88, 1, 62)];
    v.backgroundColor = kColorLightGray;
    [self addSubview:v];
    
   
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

    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    L();
    // 刷新页面
    if (_userController.isLogin) {
        
        [_userController updateUserInfoWithBlock:^(BOOL succeeded, NSError *error) {
           
            [self.tableView reloadData];
        }];

        [_networkClient queryUserNews:_userController.uid skip:0 limit:1 lastNewsId:_userController.people.lastNewsId block:^(NSDictionary *dict, NSError *error) {
            
            if (error) {
                return ;
            }
            
            NSLog(@"lastNewsId # %d",_userController.people.lastNewsId);
            
            _userController.people.newsNum = [dict[@"count"] intValue];
            
            [self.tableView reloadData];
        }];
        
    }

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
    
    cell.textLabel.textColor = kColorBlack;
    cell.textLabel.font = bFont(15);

}

// 反正没太大的关系，可以多次调用
- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"cell # %@",cell);
    int section = indexPath.section;
    int row = indexPath.row;
    
    if ([cell isKindOfClass:[UserAvatarCell class]]) {

        
        [cell setValue:_userController.people];

    }
    
    if (section == 1) {
       //AccessoryLabelCell
        
        if (row == 0) {
            // fCoupon
            int num = _userController.people.fCouponNum;
            cell.value = [NSString stringWithFormat:@"%d 张",num];
        }
        else{
            // fShop
            int num = _userController.people.fShopNum;
            cell.value = [NSString stringWithFormat:@"%d 个",num];        }
    }
    else if(section == 2){
        if ([cell isKindOfClass:[AccessoryLabelCell class]]) {
//            cell.value = @"3";
            
            NSLog(@"_userController.people.newsNum # %d",_userController.people.newsNum);
            
            if (_userController.people.newsNum > 0) {
              cell.value = [NSString stringWithInt:_userController.people.newsNum];
            }
            else{
                cell.value = @"";
            }
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

    
    UserCouponsViewController *vc = [[UserCouponsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toShops{

    
    UserShopsViewController *vc = [[UserShopsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toCards{

    UserCardsViewController *vc = [[UserCardsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)toFavoritedCoupons{

    
    
    UserFavoritedCouponsViewController *vc = [[UserFavoritedCouponsViewController alloc] initWithStyle:UITableViewStyleGrouped];
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
    
    
    [_root presentLoginWithBlock:^(BOOL succeeded, NSError *error) {

    }];
}

@end
