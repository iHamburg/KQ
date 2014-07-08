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
        
        NSLog(@"dict # %@",dict);
        
        self.id = dict[@"objectId"];
        self.title = dict[@"title"];

        
    }
    
    return self;
}


+ (instancetype)districtWithDict:(NSDictionary*)dict{
//    District *obj = [District new];
//    
//    dict = [dict dictionaryCheckNull];
//    
//    obj.id = dict[@"objectId"];
//    obj.title = dict[@"title"];
//    return obj;

    return [[District alloc] initWithDict:dict];
}

+ (instancetype)allInstance{
    District *obj = [District new];
    obj.title = @"全部商区";
    return obj;
}
@end
