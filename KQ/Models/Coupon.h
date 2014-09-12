//
//  CouponModel.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Shop.h"
#import <CoreLocation/CoreLocation.h>

@interface Coupon : NSObject



@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *discountContent;
@property (nonatomic, copy) NSString *validate;
@property (nonatomic, copy) NSString *maxNumber;
@property (nonatomic, copy) NSString *usage;
@property (nonatomic, copy) NSString *downloadedCount;

@property (nonatomic, copy) NSString *shopId; //总店



@property (nonatomic, assign) float nearestDistance; // 最近的距离，必须要有，做排序用！
@property (nonatomic, copy) CLLocation *nearestLocation;
@property (nonatomic, copy) UIImage *avatar;



+ (id)coupon;
+ (id)couponWithDict:(NSDictionary*)dict;

- (id)initWithDict:(NSDictionary*)dict;

- (void)display;
@end
