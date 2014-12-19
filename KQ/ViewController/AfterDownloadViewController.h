//
//  AfterDownload2ViewController.h
//  KQ
//
//  Created by Forest on 14-11-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"
#import "DownloadGuideView.h"


@interface AfterDownloadViewController : NetTableViewController{
    DownloadGuideView *_downloadGuideV;
}

@property (nonatomic, strong) Coupon *coupon;
@property (nonatomic, strong) DownloadGuideView *downloadGuideV;

- (void)presentAddCard;
//- (void)pushUserCoupons;
//- (void)toMain;
- (void)showDownloadGuide;
- (void)pushShopbranchList;
- (void)toCouponList;

@end
