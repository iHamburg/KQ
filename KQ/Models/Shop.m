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
        shop.distance = [[UserController sharedInstance]distanceFromLocation:shop.location];
    }
    
    return shop;
}

@end
