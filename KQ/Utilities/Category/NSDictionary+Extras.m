//
//  NSDictionary+Extras.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NSDictionary+Extras.h"

@implementation NSDictionary (Extras)

- (NSDictionary*)dictionaryCheckNull{

    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSMutableDictionary *mutDict = [self mutableCopy];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == [NSNull null]) {
            [mutDict setObject:@"" forKey:key];
        }
    }];
    
    return  [mutDict copy];

}

@end
