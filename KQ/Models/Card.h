//
//  Card.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *peopleId;
@property (nonatomic, strong) NSString *bankId;
@property (nonatomic, strong) NSString *level;

@property (nonatomic, strong) NSString *bankName;
+ (id)cardWithDict:(NSDictionary*)dict;

@end
