//
//  News.h
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *createdAt;

- (id)initWithDict:(NSDictionary*)dict;


@end
