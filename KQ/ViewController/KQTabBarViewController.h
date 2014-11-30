//
//  KQTabBarViewController.h
//  KQ
//
//  Created by Forest on 14-9-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"
#import "DropDownShopListViewController.h"
#import "KQSearchViewController.h"
#import "UserCenterViewController.h"

@interface KQTabBarViewController : UITabBarController<UITabBarControllerDelegate>{
    
    MainViewController *_mainVC;
    DropDownShopListViewController *_aroundVC;
    KQSearchViewController *_searchVC;
    UserCenterViewController *_userCenterVC;
}

@end
