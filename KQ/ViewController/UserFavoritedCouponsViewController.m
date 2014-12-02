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
    
     self.config = [[TableConfiguration alloc] initWithResource:@"CouponMyListConfig"];
    
    self.title = @"我收藏的快券";
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if (ISEMPTY(_models)) {
        return;
    }
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(ISEMPTY(self.models)){
        return;
    }
    
  
    
    Coupon *coupon = self.models[indexPath.row];
    
    if (coupon.active) {
        [self toCouponDetails:coupon];

    }
    else{
        
        [_libraryManager startHint:@"该收藏快券已失效"];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Fcns

///还是要调用的，因为people不会include favoritedCoupon的信息
- (void)loadModels{
    L();
    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [self willDisconnectInView:self.view];
        [self.refreshControl endRefreshing];
        
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

            if (ISEMPTY(array)) {
                [_libraryManager startHint:@"还没有收藏快券"];
            }
            
//            NSLog(@"array # %@",array);
            
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithFavoriteDict:dict];
                [self.models addObject:coupon];
            }
            
//            if (self.models.count <kLimit) {
//                self.isLoadMore = NO;
//            }
            
            [self.tableView reloadData];
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
    [_networkClient queryFavoritedCoupon:_userController.uid skip:count block:^(NSDictionary *couponDicts, NSError *error) {
        
        finishedBlock();
        
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];
            
//            [self addCouponsInModel:array];
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithListDict:dict];
                [self.models addObject:coupon];
            }
            
            [self.tableView reloadData];

            
        }
        else{
            [ErrorManager alertError:error];
        }
        
        
    }];

}

- (void)toCouponDetails:(Coupon*)coupon{
//

//    [_root toCouponDetails:coupon];
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
