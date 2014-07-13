//
//  AroundViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AroundViewController.h"

#import "CouponType.h"
#import "District.h"
#import <CoreLocation/CoreLocation.h>
#import "AVOSEngine.h"


@interface AroundViewController (){
    
}

@end

@implementation AroundViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"附近";
    
    self.isLoadMore = NO;
    
    self.config = [[TableConfiguration alloc] initWithResource:@"AroundConfig"];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//
//#pragma mark - TableView
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40.0f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    return dropDownView;
//    
//}
//- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
//    
////    NSLog(@"config cell # %@",[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row ]);
//    
//    if ([cell isKindOfClass:[CouponListCell class]]) {
//        
//        Coupon *project = _models[indexPath.row];
//        
//        [cell setValue:project];
//        
//    }
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [self toCouponDetails:_models[indexPath.row]];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//#pragma mark - Fcns
//
//- (void)loadModels{
//    
//    [_libraryManager startProgress:nil];
//    
//    [self.models removeAllObjects];
// 
//    
//
//    /// 当前的位置
//    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
//    NSMutableDictionary *params = [@{@"latitude":[NSString stringWithFormat:@"%f",coord.latitude],@"longitude":[NSString stringWithFormat:@"%f",coord.longitude]} mutableCopy];
// 
//    if (self.couponTypeIndex>0) {
//        CouponType *obj = self.couponTypes[self.couponTypeIndex-1];
//
//        [params setObject:obj.id forKey:@"couponTypeId"];
//    }
//    
//    if (self.districtIndex > 0) {
//        District *obj = self.districts[self.districtIndex-1];
//        [params setObject:obj.id forKey:@"districtId"];
//    }
////    NSLog(@"param # %@",params);
//    
//    [_networkClient getWithUrl:[RESTHOST stringByAppendingFormat:@"/nearestCoupon"] parameters:params block:^(NSArray* response, NSError *error) {
//        
//        [_libraryManager dismissProgress:nil];
//        
////        NSLog(@"nearest # %@",shops);
//        
//        ///如果没有返回结果
//        if (ISEMPTY(response)) {
//            NSLog(@"no results");
//            [_libraryManager startHint:@"暂时没有找到优惠券"];
//        }
//        
//        /// 获得所有的shop，然后再次query coupons
//        
//        for (NSDictionary *dict in response) {
//            
//            NSDictionary *couponDict = dict[@"coupon"];
//            
//         
//            Coupon *coupon = [Coupon couponWithDict:couponDict];
//            
//            /// add distance to coupon
//            NSDictionary *locationDict = dict[@"location"];
//            CLLocation *couponLocation = [AVOSEngine locationFromGeoPointDict:locationDict];
//            
//            
//            coupon.nearestDistance = [_userController distanceFromLocation:couponLocation]; //
//            coupon.nearestLocation = [AVOSEngine locationFromGeoPointDict:locationDict];
//            
//            [self.models addObject:coupon];
//
//        }
//    
//        
//        
//        ///models 根据coupon的nearestDistance排序
//        
//        self.models = [[self.models sortedArrayUsingFunction:nearestSort context:nil] mutableCopy];
//    
//        
//        [self.tableView reloadData];
//    }];
//    
//}
//
//int nearestSort(Coupon* obj1, Coupon* obj2, void *context ) {
//    // returns random number -1 0 1
//    return obj1.nearestDistance - obj2.nearestDistance;
//}
//
//- (void)toCouponDetails:(Coupon*)coupon{
//    
//     [self performSegueWithIdentifier:@"toCouponDetails" sender:coupon];
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"toCouponDetails"])
//    {
//
//        [segue.destinationViewController setValue:sender forKeyPath:@"coupon"];
//        
//    }
//}

@end
