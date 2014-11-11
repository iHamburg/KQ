//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"

#define kIsMainApplyEvent  YES


@class KQTabBarViewController;
@class Coupon;

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC;
    UINavigationController *_nav;  // above在tab上的nav
    
}


- (void)toLogin;



- (void)toCouponDetails:(Coupon*)coupon;


- (void)toMyCoupons;
//- (void)didLogin;
- (void)didLogout;




@end
