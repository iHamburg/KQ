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

- (IBAction)segmentedControlChanged:(id)sender;

- (void)queryCoupons:(CouponStatus)status;

- (void)toCouponDetails:(id)coupon;

@end
