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
    obj.subTypes = self.subTypes;
    obj.parentId = self.parentId;
    
    return obj;
}

- (id)initWithDict:(NSDictionary*)dict{

    if (self = [super init]) {
        
        NSLog(@"dict # %@",dict);
        
        dict = [dict dictionaryCheckNull];
        
//        NSLog(@"coupon dict # %@",dict);
        
        self.id = dict[@"objectId"];
        self.title = dict[@"title"];

        if (!ISEMPTY(dict[@"subTypes"])) {
            
            NSArray *array = dict[@"subTypes"];
            
            
            NSMutableArray *subDistricts = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                if ([dict isKindOfClass:[NSNull class]]) {
                    continue;
                }
                
                CouponType *type = [CouponType couponTypeWithDict:dict];
                [subDistricts addObject:type];
            }
            
            self.subTypes = subDistricts;
            
        }
        
        if (!ISEMPTY(dict[@"parent"])) {
            self.parentId = dict[@"parentId"][@"objectId"];
        }

    }
    
    return self;
}

+ (id)couponTypeWithDict:(NSDictionary*)dict{
    
    return [[CouponType alloc] initWithDict:dict];
}

+ (id)allInstance{
    CouponType *obj = [CouponType new];

    obj.title = @"全部分类";
    
    return obj;
}
@end
