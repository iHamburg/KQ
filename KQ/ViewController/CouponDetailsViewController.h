//
//  CouponDetaisViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"
#import "Coupon.h"
#import "Shop.h"
#import "DownloadGuideView.h"

@interface CouponDetailsViewController : ConfigViewController<UIAlertViewDelegate>{

    UIAlertView *_alert;
    
}

@property (nonatomic, strong) Coupon *coupon;
@property (nonatomic, strong) DownloadGuideView *downloadGuideV;

@property (nonatomic, assign) BOOL isFavoritedCoupon;  ///被headerCell observe


//- (void)downloadCoupon:(Coupon*)coupon;
- (void)downloadCoupon:(Coupon*)coupon sender:(id)sender;
- (void)toggleFavoriteCoupon:(Coupon*)coupon;
- (void)favoriteCoupon:(Coupon*)coupon;
- (void)unfavoriteCoupon:(Coupon*)coupon;
- (void)shareCoupon:(Coupon*)coupon;



- (void)presentAddCard;
- (void)pushCoupon:(Coupon*)coupon;

- (void)pushShop;
- (void)pushShopList;
- (void)pushAfterDownload;
- (void)pushMyCoupons;

- (void)showDownloadGuide;
@end
