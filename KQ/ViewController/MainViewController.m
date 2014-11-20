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

#define headerHeight 162

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券";
    self.navigationController.tabBarItem.title = @"首页";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"MainConfig"];
//    self.config = [[TableConfiguration alloc] initWithResource:@"MainConfig2"];
    
    self.tableView.backgroundColor = kColorBG;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}


#pragma mark - TableView

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];

    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(0, 0, _w, 122) title:nil bgImageName:@"event_banner.jpg" target:self action:@selector(handleBannerTap:)];
    
        CGFloat fontSize = 12;
    float y = 122;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, y, 60, 38)];
        [label setFont:[UIFont fontWithName:kFontName size:fontSize]];
        label.text = @"热门快券";
    label.textColor = kColorDardGray;
    
        UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(70, y, 40, 38)];
        l2.text = @"HOT";
        l2.textColor = kColorYellow;
        [label setFont:[UIFont fontWithName:kFontName size:fontSize]];
    
    [v addSubview:btn];
        [v addSubview:label];
        [v addSubview:l2];
        
        return v;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return headerHeight;
}

- (void)initConfigCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    [super initConfigCell:cell atIndexPath:indexPath];
 

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
    
    if (indexPath.section == 0) {
        
        Coupon *coupon = _models[indexPath.row];
        
        [_root toCouponDetails:coupon];
        
    }
 

}

#pragma mark - IBAction

- (IBAction)handleBannerTap:(id)sender{
    
    Coupon *coupon = [[Coupon alloc] init];
    coupon.id = @"39";
    
    [self toCouponDetails:coupon];
}

#pragma mark - Fcns



/// 返回基本coupon，在load list的时候再载入购买人数的数据
- (void)loadModels{

    L();

  
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    [_networkClient queryHotestCouponsSkip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        if (!_networkFlag) {
            return ;
        }
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

            [self addCouponsInModel:array];
            
        }
        else{
            [ErrorManager alertError:error];
        }
        
    }];
  
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}

- (void)loadMore:(VoidBlock)finishedBlock{
    
    
    int count = [_models count];
    
//    NSLog(@"networkflag # %d",_networkFlag);
    
    _networkFlag = YES;
    //从现有的之后进行载入
    [_networkClient queryHotestCouponsSkip:count block:^(NSDictionary *couponDicts, NSError *error) {
        
        finishedBlock();
      
        if (!_networkFlag) {
            return ;
        }
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];
            
            [self addCouponsInModel:array];
         
            
        }
        else{
            [ErrorManager alertError:error];
        }
        

    }];
}



- (void)toCouponDetails:(Coupon*)coupon{

    //把tab切换出去！
    [_root toCouponDetails:coupon];
}



- (void)addCouponsInModel:(NSArray *)array {
    for (NSDictionary *dict in array) {
        Coupon *coupon = [[Coupon alloc] initWithListDict:dict];
        [self.models addObject:coupon];
        
    }
    
    [self.tableView reloadData];
}

@end
