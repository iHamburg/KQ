//
//  ShopListCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-6.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopListCell.h"
#import "UIImageView+WebCache.h"

@implementation ShopListCell

- (void)setValue:(Shop*)shop{

    _value = shop;
    
    
    self.textLabel.text = shop.title;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:shop.logoUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.secondLabel.text = shop.district;
    self.thirdLabel.text = [NSString stringWithFormat:@"%@/人",shop.averagePreis];
//    _downloadedL.text = shop.distance;
        _downloadedL.text = [NSString stringWithFormat:@"%.2fkm",shop.locationDistance];
    
}

- (void)load{
   
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
    _secondLabel = [[KQLabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.textLabel.frame)-5, width, 20)];
    _secondLabel.font = bFont(12);
//    _secondLabel.textAlignment = NSTextAlignmentLeft;
    _secondLabel.textColor = kColorGray;
    
    //discountCountent
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_secondLabel.frame), 8, 20)];
    l.text = @"￥";
    l.textColor = kColorRed;
    l.font = bFont(12);
    
    _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectMake(x+8, CGRectGetMaxY(_secondLabel.frame), 50, 20)];
    _thirdLabel.font = bFont(12);
    _thirdLabel.textColor = kColorGray;
    
    
    _downloadedL = [[KQLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_thirdLabel.frame), 44, _w -CGRectGetMaxX(_thirdLabel.frame) - 10, 55)];
    _downloadedL.font = [UIFont fontWithName:kFontName size:11];
    _downloadedL.textColor = kColorGray;
    _downloadedL.textAlignment  = NSTextAlignmentRight;
    
    [self addSubview:l];
    [self addSubview:_downloadedL];
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews{}
@end
