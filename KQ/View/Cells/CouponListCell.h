//
//  CouponListCell.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "ConfigCell.h"
#import "Coupon.h"

@interface CouponListCell : ConfigCell{
    UILabel *_downloadedL;
}

@property (nonatomic, strong) NSString *text;

@end
