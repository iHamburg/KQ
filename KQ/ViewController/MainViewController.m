//
//  MainViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MainViewController.h"
#import "Coupon.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"
#import "KQRootViewController.h"
#import "CityViewController.h"
#import "ImageCell.h"
#import "CouponDetailsViewController.h"


#pragma mark - MainViewController

@interface MainViewController (){
    UINavigationController *_couponDetailsNav;

}

@property (nonatomic, strong) Coupon *eventCoupon;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券";
    self.navigationController.tabBarItem.title = @"首页";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"mainConfig"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
//    NSString *city = _userController.city;
//    if (ISEMPTY(city)) {
//        city = @"选择城市";
//    }
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(cityPressed:)];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}



//#pragma mark - IBAction
//
//- (IBAction)cityPressed:(id)sender{
//    //    L();
//}

#pragma mark - TableView

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else{
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 38)];
        v.backgroundColor = kColorTableBG;
        
        CGFloat fontSize = 13;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 38)];
        [label setFont:[UIFont fontWithName:kFontName size:fontSize]];
        label.text = @"热门快券";
        
        UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 40, 38)];
        l2.text = @"HOT";
        l2.textColor = kColorYellow;
        [label setFont:[UIFont fontWithName:kFontName size:fontSize]];
        
        [v addSubview:label];
        [v addSubview:l2];
        
        return v;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        return 40;
    }
    return 1.0f;
    

}

- (void)initConfigCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if([cell isKindOfClass:[ImageCell class]]){
        
        [cell setValue:[UIImage imageNamed:@"event_banner.jpg"]];
        
        //点击活动的banner
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBannerTap:)]];
        
        
    }

}

- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
          Coupon *project = _models[indexPath.row];
        
         [cell setValue:project];
   
    }
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    L();
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        
        Coupon *coupon = _models[indexPath.row];
        
//        [self toCouponDetails:coupon];
        
        [_root toCouponDetails:coupon];
        
    }
 

}

#pragma mark - IBAction

- (IBAction)handleBannerTap:(id)sender{
    Coupon *eventCoupon = [[Coupon alloc] init];
    eventCoupon.id = kEventCouponId;
    eventCoupon.avatarUrl = @"http://www.quickquan.com/images/moti_coupon.jpg";
    eventCoupon.discountContent = @"0元享18元套餐";
    eventCoupon.usage = @"新用户注册即可0元享受，价值18元的美味摩提2个！榴莲慕思摩提、蓝莓味摩提香甜好味、松软曼妙口感！30家店通用";
    [self toCouponDetails:eventCoupon];
}

#pragma mark - Fcns



/// 返回基本coupon，在load list的时候再载入购买人数的数据
- (void)loadModels{

    L();

//    [_libraryManager startProgress:nil];
  
    [self.models removeAllObjects];
    
    [_networkClient queryNewestCouponsSkip:0 block:^(NSArray *couponDicts, NSError *error) {
        
//         [_libraryManager dismissProgress:nil];
        
        [self addCouponsInModel:couponDicts];
        
    }];
  
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}

- (void)loadMore:(VoidBlock)finishedBlock{
    
    
    int count = [_models count];
    
    [_networkClient queryNewestCouponsSkip:count block:^(NSArray *couponDicts, NSError *error) {
        
        [self addCouponsInModel:couponDicts];
        
        finishedBlock();
    }];
}



- (void)toCouponDetails:(Coupon*)coupon{

    [_root toCouponDetails:coupon];
}



- (void)addCouponsInModel:(NSArray *)array {
    for (NSDictionary *dict in array) {
        //            NSLog(@"dict # %@",dict);
        
        Coupon *coupon = [Coupon couponWithDict:dict];
        [self.models addObject:coupon];
        
    }
    
    [self.tableView reloadData];
   
}

@end
