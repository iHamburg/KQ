//
//  CouponModel.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
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
@property (nonatomic, copy) NSString *slogan;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *shopId; //总店
@property (nonatomic, copy) NSString *number; //张数
@property (nonatomic, copy) NSString *message; //
@property (nonatomic, copy) NSString *short_desc; //
@property (nonatomic, copy) NSString *desc; //
@property (nonatomic, copy) NSString *shopCount; //门店数量


@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) BOOL sellOut;

@property (nonatomic, assign) float nearestDistance; // 最近的距离，必须要有，做排序用！
@property (nonatomic, copy) CLLocation *nearestLocation;
@property (nonatomic, copy) UIImage *avatar;

@property (nonatomic, readonly) NSArray *shopCoupons;
@property (nonatomic, readonly) NSArray *otherCoupons;
@property (nonatomic, readonly) NSString *notice;

+ (id)coupon;
+ (id)couponWithDict:(NSDictionary*)dict;

- (id)initWithDict:(NSDictionary*)dict;
- (id)initWithListDict:(NSDictionary*)dict;
- (id)initWithFavoriteDict:(NSDictionary*)dict;
- (id)initWithDownloadedDict:(NSDictionary*)dict;
- (id)initWithDetailsDict:(NSDictionary *)dict;
- (id)initWithShortDict:(NSDictionary *)dict;

- (void)display;
@end
