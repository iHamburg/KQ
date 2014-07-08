//
//  NSObject+Extras.m
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NSObject+Extras.h"

@implementation NSObject (Extras)


- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
