//
//  CouponModel.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon

static NSArray *keys;
static NSArray *listKeys;  // 服务器列表返回的dict的key

+ (void)initialize {
    if (self == [Coupon self]) {
        // ... do the initialization ...
        
        listKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
        keys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];

    }
}

- (id)initWithDict:(NSDictionary*)dict{
    if (self= [self init]) {
        
        // 把dict的value为null的处理掉
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
//        NSLog(@"couponDict # %@",dict);
        
        NSArray *keys = @[@"title",@"avatarUrl",@"validate",@"discountContent",@"usage",@"maxNumber",@"downloadedCount"];
        
        
        self.id = dict[@"objectId"];
        self.shopId = dict[@"shop"][@"objectId"];
        
        
        for (NSString *key in keys) {
        
            [self setValue:dict[key] forKey:key];
            
        }
        
        if (!ISEMPTY(dict[@"location"])) {

            self.nearestLocation = [[CLLocation alloc]initWithLatitude:[dict[@"location"][@"latitude"] floatValue] longitude:[dict[@"location"][@"longitude"] floatValue]];
        }
        
    }
    

    
    return self;
}

- (id)initWithListDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }

        for (NSString *key in listKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
    }
    
    return self;
}

+ (id)couponWithDict:(NSDictionary*)dict{

    return [[Coupon alloc]initWithDict:dict];
}


+ (id)coupon{
    
    Coupon *coup = [Coupon new];
    
    coup.id = @"111";
    
    coup.title = @"[19店通用] 三人行骨头王火锅";
    coup.discountContent = @"95折";
    
    return coup;
}


- (void)display{
    
    NSArray *keys = @[@"id",@"shopId",@"title",@"avatarUrl",@"validate",@"discountContent",@"usage",@"maxNumber",@"downloadedCount"];
    
    NSLog(@"--------------Begin Display Coupon # %@------------\n",self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    NSLog(@"--------------End Display----------------");
}

@end
