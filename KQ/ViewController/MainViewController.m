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
#import "BannerView.h"

#pragma mark - MainViewController

@interface MainViewController (){
    UINavigationController *_couponDetailsNav;

}

@property (nonatomic, strong) Coupon *eventCoupon;

@end

#define headerHeight 200

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券";
    self.navigationController.tabBarItem.title = @"首页";
    self.navigationItem.leftBarButtonItem = nil;
    
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponListConfig"];
    
    // navibar上的icon
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 26)];
    imgV.contentMode = UIViewContentModeCenter;
    imgV.image = [UIImage imageNamed:@"titlebar_index_center_title.png"];
    self.navigationItem.titleView = imgV;
    
    _bannerImgNames =  @[@"http://www.quickquan.com/app/image/banner_tutorial_2.jpg",@"http://www.quickquan.com/app/image/banner_coupon_39.jpg",@"http://www.quickquan.com/app/image/banner_coupon_60_2.jpg"];
    _bannerIds = @[@"0",@"39",@"60"];
    
    _bannerV = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    _bannerV.imgNames = _bannerImgNames;
    _bannerV.scrollInterval = 4.0;
    __weak MainViewController *vc = self;
    _bannerV.pageClickedBlock = ^(int index){
        L();
        NSString *couponId = vc.bannerIds[index];
        
        if ([couponId intValue] == 0) { // 如果为0 ，进入tutorial
           
            [vc showGuide];
            
        }
        else{
        
            Coupon *coupon = [Coupon new];
            coupon.id = couponId;
            [vc toCouponDetails:coupon];
        }
    };
    
    [_networkClient queryEventWithBlock:^(id object, NSError *error) {
        
//        NSLog(@"object # %@",object);
        NSArray *banners = object[@"banners"];

        NSMutableArray *imgNames = [NSMutableArray array];
        NSMutableArray *ids = [NSMutableArray array];
        if (!ISEMPTY(banners)) {
            
            for (NSDictionary *dict in banners) {
                [imgNames addObject:dict[@"imgUrl"]];
                if ([dict[@"type"] isEqualToString:@"coupon"]) {
                    [ids addObject:dict[@"id"]];
                }
                else{
                    [ids addObject:@"0"];
                }
            }
            
            
//            NSLog(@"imgNames # %@, ids # %@",imgNames,ids);
        
            vc.bannerImgNames = imgNames;
            vc.bannerIds = ids;
            
            [vc.tableView reloadData];
        
        }
 
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
     [MobClick beginLogPageView:@"Main"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}


#pragma mark - TableView

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];
    
    CGFloat fontSize = 12;
    float y = 160;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, y, 60, 38)];
    [label setFont:[UIFont fontWithName:kFontName size:fontSize]];
    label.text = @"热门快券";
    label.textColor = kColorDardGray;

    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(70, y, 40, 38)];
    l2.text = @"HOT";
    l2.textColor = kColorYellow;
    [label setFont:[UIFont fontWithName:kFontName size:fontSize]];

    [v addSubview:_bannerV];
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

    if (ISEMPTY(_models)) {
        return;
    }
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        [cell setText:[NSString stringWithFormat:@"%@下载",project.downloadedCount]];
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


#pragma mark - Fcns



/// 返回基本coupon，在load list的时候再载入购买人数的数据
- (void)loadModels{

    L();

    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    
    [_networkClient queryHotestCouponsSkip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [self willDisconnectInView:self.view];


        [self.refreshControl endRefreshing];

        
//        NSLog(@"main did load %@",couponDicts);
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

            [self addCouponsInModel:array];
            
        }
        else{
            [ErrorManager alertError:error];
        }
        
    }];
  
    
}


- (void)loadMore:(VoidBlock)finishedBlock{
    
    
    int count = [_models count];
    
//    NSLog(@"networkflag # %d",_networkFlag);
    
    _networkFlag = YES;
   
    //从现有的之后进行载入
    [_networkClient queryHotestCouponsSkip:count block:^(NSDictionary *couponDicts, NSError *error) {
        
        finishedBlock();
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];
            
            [self addCouponsInModel:array];
         
            if (self.models.count<kLimit) {
                self.isLoadMore = NO;
            }
        }
        else{
            [ErrorManager alertError:error];
        }

    }];
}

- (void)addCouponsInModel:(NSArray *)array {
    for (NSDictionary *dict in array) {
        Coupon *coupon = [[Coupon alloc] initWithListDict:dict];
        [self.models addObject:coupon];
        
    }
    
    [self.tableView reloadData];
}

- (void)toCouponDetails:(Coupon*)coupon{

    [_root toCouponDetails:coupon];

}


- (void)showGuide{
    L();
    [_root showGuide];
    
}




@end
