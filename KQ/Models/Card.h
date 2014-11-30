//
//  Card.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *bankTitle;

- (id)initWithDict:(NSDictionary*)dict;


@end
