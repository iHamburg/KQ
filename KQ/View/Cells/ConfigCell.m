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
        
//        self.firstLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
//        self.secondLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
//        self.thirdLabel = [[KQLabel alloc] initWithFrame:CGRectZero];
//        self.avatarV = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [self addSubview:self.firstLabel];
//        
//        NSLog(@"textlabel # %@,details label # %@",self.textLabel, self.detailTextLabel);
    }
    return self;
}

- (void)awakeFromNib{
    [self load];
}

- (void)load{

//    self.backgroundColor = [UIColor clearColor];

    
    self.textLabel.font = [UIFont fontWithName:kFontName size:16];
    self.detailTextLabel.font = [UIFont fontWithName:kFontName size:16];
    
    self.textLabel.textColor = kColorBlack;
    self.detailTextLabel.textColor = kColorBlack;

}

- (void)cancelOperation{
    [_op cancel];
}

+ (CGFloat)cellHeightWithValue:(id)value{
    return 45;
}

@end
