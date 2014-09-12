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

@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{

    KQTabBarViewController *_tabVC;
    UINavigationController *_nav;  // above在tab上的nav
    
}


- (IBAction)toLogin;

- (void)addVCAboveTab:(UIViewController*)vc;
- (void)removeVCFromTab:(UIViewController *)vc;

- (void)addNavVCAboveTab:(UIViewController*)vc;
- (void)removeNavVCAboveTab;

//- (void)toEventCoupon:(

- (void)didLogin;
- (void)didLogout;




@end
