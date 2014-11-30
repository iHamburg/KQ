//
//  AroundViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DropDownListViewController.h"
#import "Shop.h"
@interface DropDownShopListViewController : DropDownListViewController{
  
}

// root 覆盖
- (void)toShopDetails:(Shop*)shop;


@end
