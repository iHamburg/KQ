//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"


@interface KQRootViewController : RootViewController<UITabBarControllerDelegate>{


}


- (IBAction)toLogin;


- (void)didLogin;
- (void)didLogout;




@end
