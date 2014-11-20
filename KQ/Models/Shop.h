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
@property (nonatomic, assign) BOOL active;


@property (nonatomic, assign) CLLocationCoordinate2D coord;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign) CLLocationDistance locationDistance;


@property (nonatomic, copy) NSString *districtId;
@property (nonatomic, copy) NSArray *coupons;
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, copy) UIImage *image;


+ (instancetype)shopWithDictionary:(NSDictionary*)dict;

- (id)initWithFavoriteDict:(NSDictionary*)dict;
- (id)initWithSearchDict:(NSDictionary*)dict;
@end
