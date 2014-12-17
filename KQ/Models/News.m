//
//  News.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "News.h"

@implementation News

static NSArray *keys;

+ (void)initialize {
    if (self == [News self]) {
        // ... do the initialization ...
    
        keys = @[@"id",@"title",@"text",@"createdAt"];
        
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

    }
    
    return self;
}
@end
