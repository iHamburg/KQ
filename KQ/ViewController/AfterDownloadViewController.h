//
//  AfterDownload2ViewController.h
//  KQ
//
//  Created by Forest on 14-11-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"



@interface AfterDownloadViewController : NetTableViewController

@property (nonatomic, strong) Coupon *coupon;

- (void)presentAddCard;
//- (void)pushUserCoupons;
//- (void)toMain;
- (void)showDownloadGuide;
- (void)pushShopbranchList;

@end
