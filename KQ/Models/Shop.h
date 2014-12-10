//
//  Shop.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Shop : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *averagePreis;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *shopCount;
@property (nonatomic, assign) BOOL active;


@property (nonatomic, assign) CLLocationCoordinate2D coord;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign) CLLocationDistance locationDistance;


@property (nonatomic, copy) NSString *districtId;


@property (nonatomic, copy) UIImage *image;
@property (nonatomic, readonly) NSArray *coupons;
@property (nonatomic, readonly) NSString *logoThumbUrl;

//+ (instancetype)shopWithDictionary:(NSDictionary*)dict;

/**
 *	@brief	包括： 收藏的门店，搜索的门店，门户列表
 *
 */
- (id)initWithListDict:(NSDictionary*)dict;

//- (id)initWithSearchDict:(NSDictionary*)dict;
- (id)initWithCouponDetailsDict:(NSDictionary*)dict; //从CouponDetails传过来的dict

- (id)initWithShopDetailsDict:(NSDictionary*)dict;

@end
