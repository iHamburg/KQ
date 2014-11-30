//
//  CaptchaButton.h
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击之后就显示：重新获取（60），不能再按， 根据timer自动刷新， 60之后显示：获取验证码，可以按
@interface CaptchaButton : UIButton{
    int _count;
    NSTimer *_timer;
}

@property (nonatomic, strong) NSTimer *timer;

- (void)startTimer;
- (void)stopTimer;
- (void)updateRemainingTime;
@end
