//
//  ShopListViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"
#import "Shop.h"
///分店列表
@interface ShopBranchListViewController : NetTableViewController

@property (nonatomic, strong) NSString *headerShopId;

- (void)pushShopDetails:(Shop*)shop;
@end
