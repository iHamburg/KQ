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


//
//@interface CouponListFavoritedCell : CouponListCell
//
//@end
//
//@implementation CouponListFavoritedCell
//
//- (void)setValue:(Coupon*)value{
//    [super setValue:value];
//    
//     _secondLabel.text = value.endDate;
//    _thirdLabel.text = value.discountContent;
//    
//}
//
//
//- (void)load{
//    
//    [super load];
//    
//    self.imageView.frame = CGRectMake(10, 10, 85, 65);
//    CGFloat x = CGRectGetMaxX(self.imageView.frame) + 10;
//    CGFloat width = _w - x- 10;
//    self.textLabel.frame = CGRectMake(x, 10, width, 30);
//    self.thirdLabel.frame = CGRectMake(x, CGRectGetMaxY(self.textLabel.frame) - 5, width, 20);
//    self.secondLabel.frame = CGRectMake(x, CGRectGetMaxY(self.thirdLabel.frame), width, 20);
//  
//    _downloadedL.hidden = YES;
//}
//
//@end

//
//#pragma mark -
//#pragma mark - UserFavoritedCouponsViewController

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
    
    [self.models removeAllObjects];
    
    [self willConnect:self.view];
    
    [_networkClient queryFavoritedCoupon:_userController.uid skip:0 block:^(NSDictionary *couponDicts, NSError *error) {
        
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
//        if (!_networkFlag) {
//            return ;
//        }
        
        if (!error) {
            NSArray *array = couponDicts[@"coupons"];

//            NSLog(@"array # %@",array);
            
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithFavoriteDict:dict];
                [self.models addObject:coupon];
            }
            
            if (self.models.count <kLimit) {
                self.isLoadMore = NO;
            }
            
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
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
