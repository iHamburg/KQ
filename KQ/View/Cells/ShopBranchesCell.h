//
//  ShopCell.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigCell.h"
#import "Shop.h"

// 在CouponDetails中
@interface ShopBranchesCell : ConfigCell{

}

@property (nonatomic, strong) IBOutlet UIButton *shopListB;
@property (nonatomic, strong) IBOutlet UIButton *shopBranchBtn;
@property (nonatomic, strong) IBOutlet UIImageView *indicatorV;
@property (nonatomic, strong) IBOutlet UIImageView *nearestIndicatorV;

@property (nonatomic, copy) VoidBlock toShopListBlock;
@property (nonatomic, copy) VoidBlock toShopBlock;
@property (nonatomic, assign) int shopBranchesNum;

- (IBAction)toShopList:(id)sender;
- (IBAction)toShop:(id)sender;


@end
 