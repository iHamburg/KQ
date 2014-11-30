//
//  District.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "District.h"

@implementation District


- (id)copyWithZone:(NSZone *)zone{
    District *obj = [District new];
    obj.id = self.id;
    obj.title = self.title;
    

    return obj;
}

- (id)initWithDict:(NSDictionary*)dict{

    if (self = [super init]) {
        dict = [dict dictionaryCheckNull];
        
//        NSLog(@"dict # %@",dict);
        
        self.id = dict[@"id"];
        self.title = dict[@"title"];


    }
    
    return self;
}



+ (instancetype)allInstance{
    District *obj = [District new];
    obj.title = @"全部商区";
    return obj;
}
@end
