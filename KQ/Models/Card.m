//
//  Card.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Card.h"

@implementation Card

static NSArray *keys;


+ (void)initialize {
    if (self == [Card self]) {
        // ... do the initialization ...
        
        keys = @[@"title",@"logoUrl",@"bankTitle"];
        
        
    }
}

- (id)initWithDict:(NSDictionary*)dict{
    if (self = [self init]) {
        // 把dict的value为null的处理掉
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }

        self.id = dict[@"cardId"];

    }
    
    return self;
}



@end
