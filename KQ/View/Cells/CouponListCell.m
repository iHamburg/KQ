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
    UILabel *_downloadedL;
}

@end

@implementation CouponListCell


- (void)setValue:(Coupon*)value{

//    NSLog(@"coupon # %@",value.title);
    
    _value = value;
    
    self.textLabel.text = value.title;
    _secondLabel.text = value.discountContent;
    
    
    NSString *downloaded = value.downloadedCount;
    if (ISEMPTY(downloaded)) {
        downloaded = @"0";
    }
    _downloadedL.text = [NSString stringWithFormat:@"%@人购买",downloaded];


    
    if (value.nearestDistance) {
      _thirdLabel.text = [[CouponManager sharedInstance] stringFromDistance:value.nearestDistance];
    }

    
    [self.imageView setImageWithURL:[NSURL URLWithString:value.avatarUrl] placeholderImage:[UIImage imageNamed:@"quickquan300.jpg"]];
    
    
}

- (void)setShop:(Shop *)shop{
    _shop = shop;
    

    
}

//height: 80
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(5, 2, 310, 72)];
        bgV.backgroundColor = [UIColor colorWithRed:249.0/255 green:249.0/255 blue:249.0/255 alpha:1];
        bgV.layer.cornerRadius = 5;
        
        self.separatorInset = UIEdgeInsetsMake(0, 160, 0,160);
        
        self.imageView.frame = CGRectMake(5, 2, 112, 72);
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 3;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.textLabel.frame = CGRectMake(130, 10, 150, 20);
        self.textLabel.font = [UIFont fontWithName:kFontName size:13];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        _secondLabel = [[KQLabel alloc] initWithFrame:CGRectMake(130, CGRectGetMaxY(self.textLabel.frame), 150, 20)];
        _secondLabel.font = [UIFont fontWithName:kFontName size:12];
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        _secondLabel.textColor = kColorDarkYellow;

        _downloadedL = [[KQLabel alloc] initWithFrame:CGRectMake(130, 50, 150, 20)];
        _downloadedL.font = [UIFont fontWithName:kFontName size:11];

        _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectMake(250, 20, 60, 30)];
//        _thirdLabel.backgroundColor = [UIColor redColor];
        _thirdLabel.font = [UIFont fontWithName:kFontName size:12];
        
        [self addSubview:_downloadedL];
        [self addSubview:_secondLabel];
        [self addSubview:_thirdLabel];
        
        [self insertSubview:bgV atIndex:0];

        self.backgroundColor = [UIColor clearColor];

    
 
    }
    
    return self;
}

- (void)layoutSubviews{
//

}

@end
