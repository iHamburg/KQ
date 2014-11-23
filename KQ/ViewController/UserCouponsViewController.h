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

@interface UserCouponsViewController : NetTableViewController{

}

@property (nonatomic, assign) CouponStatus couponStatus;

- (IBAction)segmentedControlChanged:(id)sender;



- (void)toCouponDetails:(id)coupon;

@end
