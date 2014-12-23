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

- (id)initWithDict:(NSDictionary*)dict{

    if (self = [super init]) {
        
//        NSLog(@"dict # %@",dict);
        
        dict = [dict dictionaryCheckNull];
        
//        NSLog(@"coupon dict # %@",dict);
        
        self.id = dict[@"id"];
        self.title = dict[@"title"];
        self.imgUrl = dict[@"imgUrl"];

    }
    
    return self;
}

+ (id)allInstance{
    CouponType *obj = [CouponType new];

    obj.title = @"全部分类";
    
    return obj;
}
@end
