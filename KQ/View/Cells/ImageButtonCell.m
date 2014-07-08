//
//  ImageButtonCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ImageButtonCell.h"

@implementation ImageButtonCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bgV = [[UIImageView alloc] initWithFrame:CGRectZero];

        [self.contentView addSubview:_bgV];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    _bgV.frame = CGRectMake(10, 5, 300, 40);
    
}

@end
