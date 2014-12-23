//
//  UserCouponsViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"

typedef enum {
    CouponStatusUnused,
    CouponStatusUsed,
    CouponStatusExpired
} CouponStatus;

@interface UserCouponsViewController : NetTableViewController<UIAlertViewDelegate>{

    UIAlertView *_alert;
}

@property (nonatomic, assign) CouponStatus couponStatus;
@property (nonatomic, assign) NSString *mode;

- (IBAction)segmentedControlChanged:(id)sender;



- (void)pushCouponDetails:(id)coupon;

- (void)pushAddCard;
@end
