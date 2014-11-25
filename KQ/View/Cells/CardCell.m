//
//  CardCell.m
//  KQ
//
//  Created by Forest on 14-11-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CardCell.h"
#import "UIImageView+WebCache.h"


@implementation CardCell


- (void)setValue:(Card*)card{
    
    _value = card;
    
    //    NSLog(@"card.title # %@",card.title);
    
    
    self.textLabel.text = card.bankTitle;
    self.firstLabel.text = [self cardTitleWithSecurity:card.title];
    
    
    NSString *logoUrl = card.logoUrl;
    [self.imageView setImageWithURL:[NSURL URLWithString:logoUrl]];
    
    
}


//100

- (void)load{
    
    self.textLabel.textColor = kColorBlack;
    self.textLabel.font = [UIFont fontWithName:kFontBoldName size:16];
    
    
    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 24, _w-89, 60)];
    _firstLabel.textColor = kColorGray;
    _firstLabel.font = [UIFont fontWithName:kFontName size:15];
    
    [self addSubview:_firstLabel];
    
    
    self.imageView.frame = CGRectMake(10, 10, 64, 64);
    float x =CGRectGetMaxX(self.imageView.frame)+15;
    self.textLabel.frame = CGRectMake(x, 0 , 250, 60);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}


- (void)layoutSubviews{
}

/// 621111111111 => 6211 xxxx 1111
- (NSString*)cardTitleWithSecurity:(NSString*)title{
    
    NSString *newTitle;
    
    NSString *first = [title substringWithRange:NSRangeFromString(@"(0,4")];
    
    NSRange lastRange = NSMakeRange(title.length-4, 4);
    NSString *last = [title substringWithRange:lastRange];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<title.length-8; i++) {
        //        NSLog(@"i # %d, title.length # %d",i,title.length);
        [array addObject:@"*"];
    }
    
    NSString *middle = [array componentsJoinedByString:@""];
    
    newTitle = [NSString stringWithFormat:@"%@ %@ %@",first,middle,last];
    
    
    return newTitle;
}
@end