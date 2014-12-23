//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"
#import "MobClick.h"



@class KQTabBarViewController;
@class InstructionViewController;
@class Coupon;
@class CarouselView;

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC; // tabVC 只有一个，拉出来

    UINavigationController *_nav;  // tab上点击新出现的vc， 不确定nav的root是否唯一

    CarouselView *_instructionV;
    CarouselView *_guideV;
    CarouselView *_downloadGuideV;
}

@property (nonatomic, strong) InstructionViewController *instructionVC;
@property (nonatomic, readonly) UITabBar *tabBar;
@property (nonatomic, copy) BooleanResultBlock presentBlock;
@property (nonatomic, readonly) UINavigationController *nav;

// 用户第一次打开APP时显示 Instraction
- (void)showInstruction;

// 用户没有登录的时候显示活动页面
- (void)showEvent;

// 用户点击banner新手教程
- (void)showGuide;


- (void)toCouponDetails:(Coupon*)coupon;
- (void)addNavCouponList;

//- (void)toTab:(int)index;

- (void)presentNav:(UIViewController*)vc;
- (void)presentNav:(UIViewController *)vc block:(BooleanResultBlock)block;
- (void)presentLoginWithBlock:(BooleanResultBlock)block;

- (void)dismissNav;


- (void)addNavVCAboveTab:(UIViewController*)vc;
- (void)removeNavVCAboveTab;


@end
