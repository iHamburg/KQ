//
//  AutoHeightCell.m
//  KQ
//
//  Created by Forest on 14-11-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AutoHeightCell.h"

@implementation AutoHeightCell

- (void)setValue:(NSString*)value{
    
    self.textLabel.text = value;
//    CGFloat height = [AutoHeightCell cellHeightWithValue:coupon];
    float height = [AutoHeightCell cellHeightWithString:value font:[UIFont fontWithName:kFontName size:12]];
    self.textLabel.frame = CGRectMake(10, 0, self.width - 20, height);
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = nFont(12);
    self.textLabel.textColor = kColorGray;
}


+ (CGFloat)cellHeightWithString:(NSString*)text font:(UIFont*)font{
    
    //    NSLog(@"shop # %@",self.va)


    CGSize constraint = CGSizeMake(300, 10000);
    
    CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    

    return textRect.size.height + 20;
}

- (void)layoutSubviews{}
@end
