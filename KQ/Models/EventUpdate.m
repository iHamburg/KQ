//
//  EventUpdate.m
//  KQ
//
//  Created by Forest on 14-12-17.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "EventUpdate.h"

@implementation EventUpdate

- (id)initWithDict:(NSDictionary*)dict{
    
    if (self = [self init]) {
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        
        // 
        
        
    }
    
    return self;
}

@end
