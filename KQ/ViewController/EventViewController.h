//
//  EventViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-9-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#import "CouponManager.h"

@interface EventViewController : UIViewController{

    CouponManager *_couponManager;
}

@property (nonatomic, strong) Coupon *coupon; //这个Coupon是自己获得的
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) IBOutlet UIImageView *bgV;
@property (nonatomic, strong) UIButton *button;



- (void)back;
- (void)toCouponDetails;

@end
