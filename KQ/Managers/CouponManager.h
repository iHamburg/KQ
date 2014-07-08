//
//  CouponManager.h
//  KQ
//
//  Created by AppDevelopper on 14-6-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface CouponManager : NSObject


@property (nonatomic, strong) NSArray *couponTypes;
@property (nonatomic, strong) NSArray *districts;

+ (instancetype)sharedInstance;

- (NSString*)stringFromDistance:(double)distance;
- (NSString*)distanceStringFromLocation:(CLLocation*)location;
@end
