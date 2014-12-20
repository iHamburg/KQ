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
#import "MobClick.h"

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
        NSString *filePath;
        
        NSString *json = [MobClick getConfigParams:@"shopTypeJsonStr"];
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSArray *shopTypeArray =   [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

        if (error) {
            NSLog(@"error # %@",error.localizedDescription);
        }
        
       NSLog(@"shopType # %@",shopTypeArray);
        
        if (ISEMPTY(shopTypeArray)) {
            NSString *filePath = [NSString filePathForResource:@"shopTypes.plist"];
            shopTypeArray = [NSArray arrayWithContentsOfFile:filePath];
        }
        

       
//        NSLog(@"shopTypes # %@",shopTypeArray);
   
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in shopTypeArray) {
            CouponType *type = [[CouponType alloc] initWithDict:dict];
            [array addObject:type];
            
        }
        self.couponTypes = [array copy];
        
        
        
        
        filePath = [NSString filePathForResource:@"districts.plist"];
        shopTypeArray = [NSArray arrayWithContentsOfFile:filePath];
//        NSLog(@"shopTypes # %@",shopTypeArray);
        
        [array removeAllObjects];
        
        for (NSDictionary *dict in shopTypeArray) {
            District *type = [[District alloc] initWithDict:dict];
            [array addObject:type];
            
        }
        self.districts = [array copy];
       
        
        _formatter = [[MKDistanceFormatter alloc] init];
        _formatter.units = MKDistanceFormatterUnitsMetric;

    }
    return self;
}

- (NSString*)stringFromDistance:(double)distance{

    return [_formatter stringFromDistance:distance];
}

- (NSString*)distanceStringFromLocation:(CLLocation*)location{

    // 米
    CLLocationDistance distance = [location distanceFromLocation:[[UserController sharedInstance] checkinLocation]];
    
    
    NSString *distanceStr = [_formatter stringFromDistance:distance];
    
//    NSLog(@"distance # %f, str # %@",distance,distanceStr);
    
    return distanceStr;
}


- (NSArray*)searchCouponTypes{
    
    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    for (CouponType *type in self.couponTypes) {
//        int couponId = [type.id intValue];
//        switch (couponId) {
//            case 0:
//            case 1:
//            case 4:
//                
//                [array addObject:type];
//                break;
//                
//            default:
//                break;
//        }
//    }
//    
//    return [array copy];

    return self.couponTypes;
}

- (NSArray*)searchDistricts{
    return self.districts;
}

- (CouponType*)couponTypeWithTitle:(NSString*)title{

    for (CouponType *type in self.couponTypes) {
        if ([type.title isEqualToString:title]) {
            return type;
        }
    }
    return nil;
}
- (District*)districtWithTitle:(NSString*)title{

    for (District *district in self.districts) {
        if ([district.title isEqualToString:title]) {
            return district;
        }
    }
    return nil;
}

@end
