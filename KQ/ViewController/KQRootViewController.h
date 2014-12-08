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

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC; // tabVC 只有一个，拉出来

    UINavigationController *_nav;  // tab上点击新出现的vc， 不确定nav的root是否唯一
    
}

@property (nonatomic, strong) InstructionViewController *instructionVC;
@property (nonatomic, readonly) UITabBar *tabBar;
@property (nonatomic, copy) BooleanResultBlock presentBlock;

- (void)showInstruction;
- (void)showEvent;



- (void)toCouponDetails:(Coupon*)coupon;



- (void)toTab:(int)index;

- (void)presentNav:(UIViewController*)vc;
- (void)presentNav:(UIViewController *)vc block:(BooleanResultBlock)block;
- (void)presentLoginWithBlock:(BooleanResultBlock)block;

- (void)dismissNav;


- (void)addNavVCAboveTab:(UIViewController*)vc;
- (void)removeNavVCAboveTab;


@end
