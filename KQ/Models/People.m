//
//  People.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "People.h"

@implementation People

- (id)initWithDict:(NSDictionary*)dict{
    if (self = [self init]) {
        
        NSLog(@"dict # %@",dict);
        
         dict = [dict dictionaryCheckNull];
        self.id = dict[@"objectId"];
        self.phone = dict[@"phone"];
        self.avatarUrl = dict[@"avatarUrl"];
        self.nickname = dict[@"nickname"];
        
    
        //!!!: 用了copy之后，set就不能是mutableSet了,因为是Copy！！
        self.favoritedCouponIds = ISEMPTY(dict[@"favoritedCoupons"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedCoupons"]];
   
       
        ///即使dict没有favoritedShops这个key=>(null)，也能正常初始化！！
        self.favoritedShopIds = ISEMPTY(dict[@"favoritedShops"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedShops"]];
   
    }
    return self;
}


+ (id)people{
    
    People *people = [[People alloc] init];
    
    return people;
}


+ (id)peopleWithDict:(NSDictionary*)dict{
    
    return [[People alloc] initWithDict:dict];
}

@end
