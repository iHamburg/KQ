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

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *openTime;
@property (nonatomic, assign) CLLocationCoordinate2D coord;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign) CLLocationDistance distance;

@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) UIImage *image;


+ (instancetype)shopWithDictionary:(NSDictionary*)dict;

@end
