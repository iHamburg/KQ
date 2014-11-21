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
    
    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 90, 50)];
    _firstLabel.textAlignment = NSTextAlignmentRight;
    _firstLabel.textColor = kColorGray;
    _firstLabel.font = bFont(12);
    
    [self addSubview:_firstLabel];
}


@end
