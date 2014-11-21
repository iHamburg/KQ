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

    
    self.textLabel.font = [UIFont fontWithName:kFontName size:16];
    self.detailTextLabel.font = [UIFont fontWithName:kFontName size:16];
    
    self.textLabel.textColor = kColorBlack;
    self.detailTextLabel.textColor = kColorBlack;
    

}

+ (CGFloat)cellHeightWithValue:(id)value{
    return 45;
}


@end
