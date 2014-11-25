//
//  CouponSearchShortListCell.m
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponSearchShortListCell.h"

@implementation CouponSearchShortListCell

- (void)load{
    
    [super load];
    
    float x = 128;
    float width = 112;
    
    self.textLabel.frame = CGRectMake(x, 10, width, 38);
    _secondLabel.frame = CGRectMake(x, 35, width, 30);
    _thirdLabel.frame = CGRectMake(x, 44, width, 55);
    

  }

//- (void)layoutSubviews{}

@end
