//
//  AccessoryLabelCell.m
//  KQ
//
//  Created by Forest on 14-11-17.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AccessoryLabelCell.h"

@implementation AccessoryLabelCell

- (void)setValue:(NSString *)value{
    [super setValue:value];
    
    _firstLabel.text = value;
}


- (void)load{
    
    [super load];
    
//    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(266, 15, 20, 20)];

    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 140, 50)];
    _firstLabel.textAlignment = NSTextAlignmentRight;
    _firstLabel.textColor = kColorGray;
    _firstLabel.font = bFont(12);
    
    
    [self addSubview:_firstLabel];
}


@end

@implementation AccessoryRoundLabelCell


- (void)load{
    
    [super load];
    
    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(266, 15, 20, 20)];
    
    _firstLabel.font = bFont(12);
    
    
    UILabel *label = self.firstLabel;
    
    label.backgroundColor = kColorYellow;
    label.textColor = [UIColor whiteColor];
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_firstLabel];
}


@end
