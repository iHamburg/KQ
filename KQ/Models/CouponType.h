//
//  CouponType.h
//  KQ
//
//  Created by AppDevelopper on 14-6-9.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponType : NSObject<NSCopying>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSArray *subTypes;

- (id)initWithDict:(NSDictionary*)dict;

+ (id)couponTypeWithDict:(NSDictionary*)dict;

+ (id)allInstance;
@end
