//
//  CouponModel.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon

+ (id)coupon{

    Coupon *coup = [Coupon new];
    
    coup.id = @"111";

    coup.title = @"[19店通用] 三人行骨头王火锅";
    coup.discountContent = @"95折";
    
    return coup;
}


- (id)initWithDict:(NSDictionary*)dict{
    if (self= [self init]) {
        dict = [dict dictionaryCheckNull];
        
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

+ (id)couponWithDict:(NSDictionary*)dict{

    return [[Coupon alloc]initWithDict:dict];
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
