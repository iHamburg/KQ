//
//  CouponSearchListCell.m
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponSearchListCell.h"

@implementation CouponSearchListCell

- (void)setValue:(Coupon*)value{
    [super setValue:value];
    
    self.textLabel.text = value.shopbranchTitle;
    _secondLabel.text = value.discountContent;
    _thirdLabel.text = [NSString stringWithFormat:@"%@下载",value.downloadedCount];
    _downloadedL.text = value.distance;
}

- (void)load{
    [super load];
    _secondLabel.textColor = kColorYellow;
    _secondLabel.font = bFont(15);
    
    _thirdLabel.textColor = kColorGray;
    _thirdLabel.font = nFont(12);
}

@end
