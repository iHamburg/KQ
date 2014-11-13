//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"


@class KQTabBarViewController;
@class Coupon;

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC; // tabVC 只有一个，拉出来

    UINavigationController *_nav;  // tab上点击新出现的vc， 不确定nav的root是否唯一
    
}


/**
 *	@brief	present，Login页面无论如何push，最后dismiss的时候还是回到原来的页面
比如favorite shop/coupon
 应该由调用方确认结束？block！
 */
- (void)presentLogin;

/**
 *	@brief	present or not present, login页面push到随便逛逛，就不再回到couponDetails
 */
- (void)toLogin;

- (void)loginWithBlock:(BooleanResultBlock)block;


- (void)toCouponDetails:(Coupon*)coupon;


- (void)toTab:(int)index;
- (void)toNav:(UIViewController*)vc;


- (void)toMyCoupons;

- (void)didLogout;




@end
