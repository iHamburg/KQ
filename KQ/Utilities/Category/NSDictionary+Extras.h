//
//  NSDictionary+Extras.h
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extras)

/**
 * 把所有是NSNull的元素都转换成“”
 */
- (NSDictionary*)dictionaryCheckNull;

@end
