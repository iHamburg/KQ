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



/**
 *	@brief	<#Description#>
 *
 *	@param 	coupon 	<#coupon description#>
 */
- (void)toCouponDetails:(Coupon*)coupon;
 //从tab内，跳到tab外
- (void)toMyCoupons;

/**
 *	@brief	<#Description#>
 */
- (void)didLogin;
- (void)didLogout;




@end
