//
//  Shop.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Shop.h"
#import "UserController.h"
#import "Coupon.h"

@implementation Shop

static NSArray *favoriteKeys; // 用户收藏的门店key
//static NSArray *searchListKeys;  //附近搜索list的key
static NSArray *couponDetailsKeys;
static NSArray *shopDetailsKeys;

+ (void)initialize {
    if (self == [Shop self]) {
        // ... do the initialization ...
     
        favoriteKeys = @[@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"district",@"averagePreis"];
        
//        searchListKeys = @[@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"district",@"averagePreis",@"address",@"distance",@"openTime",@"phone"];
        
       
       
         couponDetailsKeys = @[@"address",@"distance",@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"averagePreis",@"openTime",@"phone"];
        
         //TODO: 需要总店id
         shopDetailsKeys = @[@"address",@"distance",@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"openTime",@"phone",@"shopCount"];

    }
}


- (id)initWithListDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in favoriteKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.active = [dict[@"active"] boolValue];
        self.coord = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
        self.location = [[CLLocation alloc] initWithLatitude:self.coord.latitude longitude:self.coord.longitude];
      
        self.locationDistance = [[UserController sharedInstance] distanceFromLocation:self.location];
    }
    
    return self;
}

//- (id)initWithSearchDict:(NSDictionary*)dict{
//    if (self = [super init]) {
//        if ([dict isKindOfClass:[NSDictionary class]]) {
//            dict = [dict dictionaryCheckNull];
//        }
//        else{
//            return self;
//        }
//        
//        for (NSString *key in searchListKeys) {
//            [self setValue:dict[key] forKey:key];
//        }
//        
//        self.parentId = dict[@"shopId"];
//    }
//    
//    return self;
//}

- (id)initWithCouponDetailsDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in couponDetailsKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.parentId = dict[@"shopId"];
        self.active = [dict[@"active"] boolValue];
    }
    
    return self;
}

- (id)initWithShopDetailsDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in shopDetailsKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.parentId = dict[@"shopId"];
        self.active = [dict[@"active"] boolValue];
        self.desc = dict[@"description"];
        /*
         shopCoupons =     (
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/coupon_id_39_new.jpg";
         discountContent = "\U7279\U4ef71\U5143";
         downloadedCount = 14;
         id = 39;
         isEvent = 1;
         isSellOut = 0;
         slogan = "\U301018\U5e97\U901a\U7528\U301118\U5143\U7f8e\U5473\U6469\U63d0\U5957\U9910";
         title = "\U6469\U63d0\U5de5\U623f";
         },
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/coupon_id_40.jpg";
         discountContent = "\U7acb\U51cf5\U5143";
         downloadedCount = 64;
         id = 40;
         isEvent = 0;
         isSellOut = 0;
         slogan = "\U301018\U5e97\U901a\U7528\U3011\U6d88\U8d39\U6ee130\U5143\U53ef\U4eab\U4f18\U60e0";
         title = "\U6469\U63d0\U5de5\U623f";
         }
         );
         */
        
        NSArray *shopCoupons = dict[@"shopCoupons"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in shopCoupons) {
            Coupon *coupon = [[Coupon alloc] initWithShopDetailsDict:dict];
            [array addObject:coupon];
        }
        _coupons = [array copy];
        
    }
    
    return self;

}
@end
