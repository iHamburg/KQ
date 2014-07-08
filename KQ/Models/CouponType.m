//
//  CouponType.m
//  KQ
//
//  Created by AppDevelopper on 14-6-9.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponType.h"

@implementation CouponType

- (id)copyWithZone:(NSZone *)zone{
    CouponType *obj = [CouponType new];
    obj.id = self.id;
    obj.title = self.title;
    
    return obj;
}

+ (id)couponTypeWithDict:(NSDictionary*)dict{
    CouponType *obj = [CouponType new];
    
    
    dict = [dict dictionaryCheckNull];
    
    obj.id = dict[@"objectId"];
    obj.title = dict[@"title"];
    return obj;
}

+ (id)allInstance{
    CouponType *obj = [CouponType new];

    obj.title = @"全部分类";
    
    return obj;
}
@end
