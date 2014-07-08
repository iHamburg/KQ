//
//  ShopViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"
#import "Shop.h"

@interface ShopDetailsViewController : ConfigViewController

@property (nonatomic, strong) Shop* shop;
@property (nonatomic, strong) NSArray *shopBranches;

@property (nonatomic, assign) BOOL shopFavorited;

- (void)toMap;
- (void)toShopList;
- (void)toCouponDetails:(id)coupon;

- (void)toggleFavoriteShop:(Shop*)shop;
- (void)favoriteShop:(Shop*)shop;
- (void)unfavoriteShop:(Shop*)shop;
@end
