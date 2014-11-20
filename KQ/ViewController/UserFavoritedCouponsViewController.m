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
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Tableview


- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    [self addSeperatorLineInCell:cell];
    
}

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
    
//    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        if (!_networkFlag) {
            return ;
        }
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

//            NSLog(@"array # %@",array);
            
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithFavoriteDict:dict];
                [self.models addObject:coupon];
            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }
     
    }];

}

///当用户refresh了收藏信息
//- (void)refreshModels{
//    [self.models removeAllObjects];
//    
//    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
//  
//        if (ISEMPTY(couponDicts)) {
//     
//        }
//        else{
//            
//            for (NSDictionary *dict in couponDicts) {
//                Coupon *coupon = [Coupon couponWithDict:dict];
//                [self.models addObject:coupon];
//                
//            }
//        }
////
//        [self.tableView reloadData];
//        
//    }];
//
//}

- (void)toCouponDetails:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
