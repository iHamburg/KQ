//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"

typedef enum {

    PresentUserCenterLogin,
    PresentDefault
}PresentMode;

@class KQTabBarViewController;
@class InstructionViewController;
@class Coupon;

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC; // tabVC 只有一个，拉出来

    UINavigationController *_nav;  // tab上点击新出现的vc， 不确定nav的root是否唯一
    
}

@property (nonatomic, assign) PresentMode presentMode;
@property (nonatomic, strong) InstructionViewController *instructionVC;
@property (nonatomic, readonly) UITabBar *tabBar;

- (void)showInstruction;

/**
 *	@brief	present，Login页面无论如何push，最后dismiss的时候还是回到原来的页面
比如favorite shop/coupon

 */
- (void)presentLoginWithMode:(PresentMode)mode;

/**
 *	@brief	present or not present, login页面push到随便逛逛，就不再回到couponDetails
 */
- (void)toLogin;

- (void)loginWithBlock:(BooleanResultBlock)block;

- (void)toCouponDetails:(Coupon*)coupon;





- (void)toMyCoupons;

//- (void)didLogout;

- (void)toTab:(int)index;

/**
 *	@brief	在present的时候需要告诉root，是什么原因调用的
 *
 *	@param 	vc 	<#vc description#>
 */
- (void)presentNav:(UIViewController*)vc mode:(PresentMode)mode;

/**
 *	@brief	在dismiss的时候都会调回default
 */
- (void)dismissNav;


- (void)addNav:(UIViewController*)vc;


@end
