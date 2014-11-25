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


@interface CouponListCell (){
    
}

@end

@implementation CouponListCell


- (void)setValue:(Coupon*)value{

//    NSLog(@"coupon # %@",value.title);
    
    _value = value;
    
    self.textLabel.text = value.title;
    
    _secondLabel.text = value.slogan;

    _thirdLabel.text = value.discountContent;
    
//    _downloadedL.text = [NSString stringWithFormat:@"%@下载",value.downloadedCount];

    //coupon_1.jpg => coupon_1_thumb.jpg
//    NSString *avatarUrl = value.avatarThumbUrl;
    
//    NSLog(@"thumbUrl # %@",avatarUrl);
    
    [self.imageView setImageWithURL:[NSURL URLWithString:value.avatarThumbUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
}

- (void)setText:(NSString *)text{
    _text = text;
    
    _downloadedL.text = text;
}

//height: 85

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
    
    
   
    [self addSubview:_secondLabel];
    [self addSubview:_thirdLabel];
    [self addSubview:_downloadedL];
    
    self.backgroundColor = [UIColor whiteColor];
    


}


- (void)layoutSubviews{


}

@end
