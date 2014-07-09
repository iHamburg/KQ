//
//  District.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface District : NSObject<NSCopying>

//branch new
// develop

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSArray *subDistricts;

- (id)initWithDict:(NSDictionary*)dict;

+ (instancetype)districtWithDict:(NSDictionary*)dict;

+ (id)allInstance;

@end
