//
//  People.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "People.h"

@implementation People

static NSArray *keys;

+ (void)initialize {
    if (self == [People self]) {
        // ... do the initialization ...

        keys = @[@"id",@"username",@"password",@"sessionToken",@"avatarUrl",@"nickname"];
    }
}


- (id)initWithDict:(NSDictionary*)dict{
    if (self = [self init]) {
        
        NSLog(@"dict # %@",dict);
     
        
        dict = [dict dictionaryCheckNull];
        if (ISEMPTY(dict)) {
            NSLog(@"People Init Error");
            return self;
        }
        
        self.id = dict[@"id"];
        self.username = dict[@"username"];
        self.avatarUrl = dict[@"avatarUrl"];
        self.nickname = dict[@"nickname"];
        self.sessionToken = dict[@"sessionToken"];
   

        //!!!: 没有用到
//        self.favoritedCouponIds = ISEMPTY(dict[@"favoritedCoupons"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedCoupons"]];
   
       
        ///即使dict没有favoritedShops这个key=>(null)，也能正常初始化！！
//        self.favoritedShopIds = ISEMPTY(dict[@"favoritedShops"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedShops"]];

//        NSLog(@"self.favoritedShopIds # %@",self.favoritedCouponIds);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    
    for (NSString *key in keys) {
//        NSLog(@"key # %@, value # %@",key,[aDecoder decodeObjectForKey:key]);
        
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{

    for (NSString *key in keys) {
//          NSLog(@"key # %@, value # %@",key,[self valueForKey:key]);
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

+ (id)people{
    L();
    People *people = [[People alloc] init];
    
    return people;
}


+ (id)peopleWithDict:(NSDictionary*)dict{
    
    return [[People alloc] initWithDict:dict];
}

@end
