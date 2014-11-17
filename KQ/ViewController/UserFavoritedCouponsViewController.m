//
//  UserFavoritedCouponsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-20.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserFavoritedCouponsViewController.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"

@interface UserFavoritedCouponsViewController ()

@end

@implementation UserFavoritedCouponsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.config = [[TableConfiguration alloc] initWithResource:@"UserCouponsConfig"];
    
    self.title = @"我收藏的快券";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 增加一个notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshModels) name:@"refreshFavoritedCoupons" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Tableview
- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = self.models[indexPath.row];
    
    [self toCouponDetails:obj];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns

///还是要调用的，因为people不会include favoritedCoupon的信息
- (void)loadModels{
    L();
    
    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];
    
    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [_libraryManager dismissProgress:nil];
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

            NSLog(@"array # %@",array);
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }
        
//        if (ISEMPTY(couponDicts)) {
//            [_libraryManager startHint:@"还没有收藏商户" duration:1];
//        }
//        else{
////            NSLog(@"couponDicts # %@",couponDicts);
//            for (NSDictionary *dict in couponDicts) {
//                Coupon *coupon = [Coupon couponWithDict:dict];
//                [self.models addObject:coupon];
//                
//            }
//        }
        
        
     
    }];

}

///当用户refresh了收藏信息
- (void)refreshModels{
    [self.models removeAllObjects];
    
    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        
        
//   
        if (ISEMPTY(couponDicts)) {
     
        }
        else{
            
            for (NSDictionary *dict in couponDicts) {
                Coupon *coupon = [Coupon couponWithDict:dict];
                [self.models addObject:coupon];
                
            }
        }
//
        [self.tableView reloadData];
        
    }];

}

- (void)toCouponDetails:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
