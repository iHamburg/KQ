//
//  UserCenterViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"



@interface UserCenterViewController : ConfigViewController<UIAlertViewDelegate>{
    People *_people;
    
}

- (IBAction)dCouponPressed:(id)sender;
- (IBAction)cardPressed:(id)sender;
- (IBAction)fCouponPressed:(id)sender;
- (IBAction)fShopPressed:(id)sender;
- (IBAction)aboutUsPressed:(id)sender;
- (IBAction)newsPressed:(id)sender;
- (IBAction)settingPressed:(id)sender;

- (void)pushEditUser;
- (void)toCoupons;
- (void)toShops;
- (void)toCards;
- (void)toFavoritedCoupons;

- (void)toSettings; //设置
- (void)pushAboutUs; //关于我们
- (void)pushNews; //站内信
- (void)presentLogin; //要求登录


@end
