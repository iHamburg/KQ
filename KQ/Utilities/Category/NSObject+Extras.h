//
//  NSObject+Extras.h
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extras)

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

@end
