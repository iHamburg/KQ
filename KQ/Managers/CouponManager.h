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

@interface CouponManager : NSObject


@property (nonatomic, strong) NSArray *couponTypes; //只有一级coupontype
@property (nonatomic, strong) NSArray *districts;   //只有一级区域

+ (instancetype)sharedInstance;

/**
 *	@brief	<#Description#>
 *
 *	@param 	title 	<#title description#>
 *
 *	@return	如果出错返回nil
 */
- (CouponType*)couponTypeWithTitle:(NSString*)title;

- (District*)districtWithTitle:(NSString*)title;

- (NSString*)stringFromDistance:(double)distance;
- (NSString*)distanceStringFromLocation:(CLLocation*)location;

@end
