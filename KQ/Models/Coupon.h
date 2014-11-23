//
//  CouponModel.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class Shop;

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
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *shopbranchTitle;

@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) BOOL sellOut;

@property (nonatomic, assign) float nearestDistance; // 最近的距离，必须要有，做排序用！
@property (nonatomic, copy) CLLocation *nearestLocation;
@property (nonatomic, copy) UIImage *avatar;

@property (nonatomic, readonly) NSArray *shopCoupons;
@property (nonatomic, readonly) NSArray *otherCoupons;
@property (nonatomic, readonly) Shop *nearestShopBranch;
@property (nonatomic, readonly) NSString *notice; //使用时间 + 使用规则

+ (id)eventCoupon;

- (id)initWithDict:(NSDictionary*)dict;
/**
 *	@brief	首页的快券列表
 */
- (id)initWithListDict:(NSDictionary*)dict;
/**
 *	@brief	收藏的快券列表
 */
- (id)initWithFavoriteDict:(NSDictionary*)dict;
/**
 *	@brief	下载的快券列表
 */
- (id)initWithDownloadedDict:(NSDictionary*)dict;
/**
 *	@brief	快券详情
 */
- (id)initWithDetailsDict:(NSDictionary *)dict;
/**
 *	@brief	快券详情中的其他的快券
 */
- (id)initWithShortDict:(NSDictionary *)dict;
/**
 *	@brief	收藏的快券列表
 */
- (id)initWithShopDetailsDict:(NSDictionary*)dict;

- (id)initWithSearchDict:(NSDictionary*)dict;

- (void)display;
@end
