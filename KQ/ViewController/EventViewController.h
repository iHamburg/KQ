//
//  EventViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-9-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#import "InteractiveButton.h"

@interface EventViewController : UIViewController

@property (nonatomic, strong) Coupon *coupon; //这个Coupon是自己获得的
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) IBOutlet UIImageView *bgV;
@property (nonatomic, strong) InteractiveButton *button;

//@property (nonatomic, copy) void(^toEventCoupon)(Coupon*); //没有必要由root来控制toEventCoupon的流程，



- (void)back;
- (void)toCouponDetails;

@end
