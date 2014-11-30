//
//  CaptchaButton.m
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CaptchaButton.h"

@implementation CaptchaButton

- (void)startTimer{
    self.userInteractionEnabled = NO;
    _count = 60;
    
    [self updateRemainingTime];
    
    if (self.timer==nil) {
        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateRemainingTime) userInfo:nil repeats:YES];
        NSRunLoop *main = [NSRunLoop currentRunLoop];
        [main addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
- (void)stopTimer{
    
    self.userInteractionEnabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}
- (void)updateRemainingTime{
//    L();
    _count--;
    [self setTitle:[NSString stringWithFormat:@"重新获取(%d)",_count] forState:UIControlStateNormal];
    if (_count<0) {
        [self stopTimer];
    }
}

@end
