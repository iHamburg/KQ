//
//  CouponListCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponListCell.h"
#import "UIImageView+WebCache.h"
#import "NetworkClient.h"
#import "CouponManager.h"
#import "Coupon.h"

@interface CouponListCell (){
    UILabel *_downloadedL;
}

@end

@implementation CouponListCell


- (void)setValue:(Coupon*)value{

//    NSLog(@"coupon # %@",value.title);
    
    _value = value;
    
    self.textLabel.text = value.title;
    
    _secondLabel.text = value.slogan;

    _thirdLabel.text = value.discountContent;
    
    _downloadedL.text = [NSString stringWithFormat:@"%@下载",value.downloadedCount];

    
    [self.imageView setImageWithURL:[NSURL URLWithString:value.avatarUrl] placeholderImage:[UIImage imageNamed:@"quickquan300.jpg"]];
    
    
}

- (void)setShop:(Shop *)shop{
    _shop = shop;
    

    
}

//height: 85

- (void)load{
    
//    L();
  
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0,0); // 分割线是全屏的
    
    self.imageView.frame = CGRectMake(10, 10, 108, 76);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CGFloat x = CGRectGetMaxX(self.imageView.frame) + 10;
    CGFloat width = _w - x- 10;
    // title
    self.textLabel.frame = CGRectMake(x, 10, width, 38);
    self.textLabel.font = [UIFont fontWithName:kFontBoldName size:16];
    self.textLabel.textAlignment = NSTextAlignmentLeft;

    
    //slogan
    _secondLabel = [[KQLabel alloc] initWithFrame:CGRectMake(x, 35, width, 30)];
    _secondLabel.font = [UIFont fontWithName:kFontBoldName size:11];
    _secondLabel.textAlignment = NSTextAlignmentLeft;
    _secondLabel.textColor = kColorGray;
    
    //discountCountent
    _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectMake(x, 44, 125, 55)];
    _thirdLabel.font = [UIFont fontWithName:kFontBoldName size:15];
    _thirdLabel.textColor = kColorYellow;
    
    
    _downloadedL = [[KQLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_thirdLabel.frame), 44, _w -CGRectGetMaxX(_thirdLabel.frame) - 10, 55)];
    _downloadedL.font = [UIFont fontWithName:kFontName size:11];
    _downloadedL.textColor = kColorGray;
    _downloadedL.textAlignment  = NSTextAlignmentRight;
    
    
    [self addSubview:_downloadedL];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    
    
    self.backgroundColor = [UIColor whiteColor];
    


}


- (void)layoutSubviews{


}

@end
