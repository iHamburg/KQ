//
//  EventUpdate.h
//  KQ
//
//  Created by Forest on 14-12-17.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventUpdate : NSObject

@property (nonatomic, strong) NSString *eventImgUrl;
@property (nonatomic, strong) NSString *eventButtonUrl;
@property (nonatomic, strong) NSString *eventCouponId;

@property (nonatomic, strong) NSMutableArray *banners;

- (id)initWithDict:(NSDictionary*)dict;



@end
