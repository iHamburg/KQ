//
//  ShopCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopBranchesCell.h"
#import "Shop.h"
#import "KQLabel.h"
#import "CouponManager.h"


// 123: 85+38
@implementation ShopBranchesCell

- (void)setValue:(Shop*)shop{
    
    _value = shop;
    
    
//    NSLog(@"shop locatio # %f,%f",shop.coord.latitude,shop.coord.longitude);
    

    self.firstLabel.text = shop.title;
    
    if (shop.location) {
        self.secondLabel.text = [[CouponManager sharedInstance] distanceStringFromLocation:shop.location];
    }
    
    self.thirdLabel.text = shop.address;

}

- (void)setShopBranchesNum:(int)shopBranchesNum{
    _shopBranchesNum = shopBranchesNum;

    [self.shopListB setTitle:[NSString stringWithFormat:@"查看全部%d家商户",shopBranchesNum] forState:UIControlStateNormal];
}


- (void)awakeFromNib{

    [self.contentView removeFromSuperview];
    

}


- (void)layoutSubviews{
    
    
}

#pragma mark - AlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    NSLog(@"button # %d",buttonIndex);
    
    if (buttonIndex == 1) {
        [self didDialPhone];
    }
}

#pragma mark - IBAction

- (IBAction)dialPhone:(id)sender{

    _phoneNumber = [(Shop*)_value phone];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"拨打电话: %@?",_phoneNumber] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alert show];
}
- (IBAction)toMap:(id)sender{

    _toMapBlock(self.value);
}
- (IBAction)toShopList:(id)sender{

    _toShopListBlock();
}

- (void)didDialPhone{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]];
}
@end
