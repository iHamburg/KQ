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
    obj.parentId = self.parentId;
    obj.subDistricts = self.subDistricts;

    return obj;
}

- (id)initWithDict:(NSDictionary*)dict{

    if (self = [super init]) {
        dict = [dict dictionaryCheckNull];
        
//        NSLog(@"dict # %@",dict);
        
        self.id = dict[@"objectId"];
        self.title = dict[@"title"];

        if (!ISEMPTY(dict[@"subDistricts"])) {
            
            NSArray *array = dict[@"subDistricts"];
          
            
            NSMutableArray *subDistricts = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                District *district = [District districtWithDict:dict];
                [subDistricts addObject:district];
            }
            
            self.subDistricts = subDistricts;
            
        }
        
        if (!ISEMPTY(dict[@"parent"])) {
            self.parentId = dict[@"parentId"][@"objectId"];
        }
    }
    
    return self;
}


+ (instancetype)districtWithDict:(NSDictionary*)dict{

    return [[District alloc] initWithDict:dict];
}

+ (instancetype)allInstance{
    District *obj = [District new];
    obj.title = @"全部商区";
    return obj;
}
@end
