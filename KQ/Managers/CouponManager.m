//
//  CouponManager.m
//  KQ
//
//  Created by AppDevelopper on 14-6-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponManager.h"
#import "NetworkClient.h"
#import "CouponType.h"
#import "District.h"
#import <MapKit/MapKit.h>
#import "LibraryManager.h"
#import "UserController.h"

@interface CouponManager(){
    NetworkClient *_networkClient;
    MKDistanceFormatter *_formatter;
}

@end

@implementation CouponManager

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
     

        _networkClient = [NetworkClient sharedInstance];
        
     
        [[LibraryManager sharedInstance] startProgress:@"queryCouponType"];
        
        [_networkClient queryHeadCouponTypesWithBlock:^(NSArray *array, NSError *error) {
            if (array) {
//               NSLog(@"types # %@",array);
                
                NSMutableArray *types = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    CouponType *obj = [CouponType couponTypeWithDict:dict];
                    [types addObject:obj];
                }
                
                self.couponTypes = types;
                
          
                [[LibraryManager sharedInstance] dismissProgress:@"queryCouponType"];
            }
        }];
        

        [[LibraryManager sharedInstance] startProgress:@"queryDistricts"];
        [_networkClient queryHeadDistrictsWithBlock:^(NSArray *array, NSError *error) {
            if (array) {
//                    NSLog(@"distric # %@",array);
                
                NSMutableArray *types = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    District *obj = [District districtWithDict:dict];
                    [types addObject:obj];
                }
                
                self.districts = types;


                [[LibraryManager sharedInstance] dismissProgress:@"queryDistricts"];

            }
            

            _formatter = [[MKDistanceFormatter alloc] init];
            _formatter.units = MKDistanceFormatterUnitsMetric;


        }];
    }
    return self;
}

- (NSString*)stringFromDistance:(double)distance{

    return [_formatter stringFromDistance:distance];
}

- (NSString*)distanceStringFromLocation:(CLLocation*)location{

    CLLocationDistance distance = [location distanceFromLocation:[[UserController sharedInstance] checkinLocation]];
    
    return [_formatter stringFromDistance:distance];
}
@end
