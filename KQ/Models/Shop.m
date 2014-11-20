//
//  Shop.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Shop.h"
#import "UserController.h"

@implementation Shop

static NSArray *favoriteKeys; // 用户收藏的门店key
static NSArray *searchListKeys;  //附近搜索list的key

+ (void)initialize {
    if (self == [Shop self]) {
        // ... do the initialization ...
        
//        listKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
//        keys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
        
        favoriteKeys = @[@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"district",@"averagePreis"];
        
        searchListKeys = @[@"id",@"title",@"logoUrl",@"longitude",@"latitude",@"district",@"averagePreis",@"address",@"distance",@"openTime",@"phone"];
        
        //TODO: 需要总店id
       

    }
}

+ (instancetype)shopWithDictionary:(NSDictionary*)dict{
    
    /// shop 没有储存shopBranches元素，是交给VC来储存了
    
    Shop *shop = [Shop new];
    
    dict = [dict dictionaryCheckNull];
    
//    NSLog(@"dict # %@",dict);
    
    
    shop.id = dict[@"objectId"];
    NSArray *keys = @[@"parentId",@"address",@"phone",@"title",@"openTime",@"desc",@"posterUrl"];
    for (NSString *key in keys) {
        
        //        NSLog(@"key # %@",key);
        
        [shop setValue:dict[key] forKey:key];
    }
    
    NSDictionary *locationArr = dict[@"location"];
    if (!ISEMPTY(locationArr)) {
        shop.coord = CLLocationCoordinate2DMake([locationArr[@"latitude"] doubleValue], [locationArr[@"longitude"] doubleValue]);
        shop.location = [[CLLocation alloc] initWithLatitude:shop.coord.latitude longitude:shop.coord.longitude];
        shop.locationDistance = [[UserController sharedInstance]distanceFromLocation:shop.location];
    }
    
    return shop;
}

- (id)initWithFavoriteDict:(NSDictionary*)dict{
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
    }
    
    return self;
}

- (id)initWithSearchDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in searchListKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.parentId = dict[@"shopId"];
    }
    
    return self;
}

@end
