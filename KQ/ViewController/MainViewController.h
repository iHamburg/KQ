//
//  MainViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"


@interface MainViewController : NetTableViewController


- (IBAction)handleBannerTap:(id)sender;


- (void)toCouponDetails:(id)couponModel; /// 从root调用detais+nav，盖在tab上


@end
