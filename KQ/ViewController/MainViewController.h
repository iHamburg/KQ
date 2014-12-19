//
//  MainViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"
#import "BannerView.h"
@interface MainViewController : NetTableViewController{

    BannerView *_bannerV;
    NSArray *_bannerImgNames;
    NSArray *_bannerIds;
}

@property (nonatomic, strong) NSArray *bannerIds;
@property (nonatomic, strong) NSArray *bannerImgNames;


- (void)toCouponDetails:(id)coupon; /// root addNavVCAboveTab
- (void)showGuide;

@end
