//
//  ConfigCell.m
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigCell.h"

@implementation ConfigCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self load];
        
    }
    return self;
}

- (void)awakeFromNib{
    [self load];
}

- (void)load{

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    

    _firstLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
    _secondLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
    _thirdLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
    _fourthLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
    
        [self addSubview:_firstLabel];
        [self addSubview:_secondLabel];
        [self addSubview:_thirdLabel];
        [self addSubview:_fourthLabel];
    
}

+ (CGFloat)cellHeightWithValue:(id)value{
    return 45;
}


@end
