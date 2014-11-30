//
//  CouponMyListCell.m
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponMyListCell.h"

@implementation CouponMyListCell

- (void)setValue:(Coupon*)value{
    [super setValue:value];
    
    _secondLabel.text = value.discountContent;
    _thirdLabel.text = value.endDate;
}

- (void)load{
    [super load];
    _secondLabel.textColor = kColorYellow;
    _secondLabel.font = bFont(15);
    
    _thirdLabel.textColor = kColorGray;
    _thirdLabel.font = nFont(12);
}

@end
