//
//  CouponListViewController.m
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponListViewController.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"

@interface CouponListViewController ()

@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券列表";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponListConfig"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView
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
        
        [self pushCouponDetails:coupon];
    }
    
    
}

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

- (void)pushCouponDetails:(Coupon*)coupon{

    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
