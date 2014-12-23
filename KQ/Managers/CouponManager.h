//
//  CouponManager.h
//  KQ
//
//  Created by AppDevelopper on 14-6-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CouponType.h"
#import "District.h"
#import "Coupon.h"

@interface CouponManager : NSObject

//@property (nonatomic, strong) 
@property (nonatomic, strong) NSArray *couponTypes; //只有一级coupontype
@property (nonatomic, strong) NSArray *districts;   //只有一级区域


+ (instancetype)sharedInstance;

/**
 *
 *	@return	如果出错返回nil
 */
- (CouponType*)couponTypeWithTitle:(NSString*)title;

- (District*)districtWithTitle:(NSString*)title;

- (NSArray*)searchCouponTypes; //id 0,1,4
- (NSArray*)searchDistricts; //全部

- (NSString*)stringFromDistance:(double)distance;
- (NSString*)distanceStringFromLocation:(CLLocation*)location;

@end
