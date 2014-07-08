//
//  ShopCell.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponCell.h"



@interface ShopBranchesCell : CouponCell<UIAlertViewDelegate>{

    NSString *_phoneNumber;
}

@property (nonatomic, strong) IBOutlet UIButton *shopListB;
@property (nonatomic, strong) IBOutlet UIImageView *indicatorV;
@property (nonatomic, strong) IBOutlet UIImageView *nearestIndicatorV;

@property (nonatomic, copy) void(^toMapBlock)(Shop*) ;
@property (nonatomic, copy) VoidBlock toShopListBlock;

@property (nonatomic, assign) int shopBranchesNum;

- (IBAction)dialPhone:(id)sender;
- (IBAction)toMap:(id)sender;
- (IBAction)toShopList:(id)sender;

- (void)didDialPhone;
@end
 