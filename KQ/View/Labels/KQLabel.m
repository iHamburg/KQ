//
//  MKLabel.m
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQLabel.h"

@implementation KQLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

//        self.font = [UIFont fontWithName:kFontName size:self.height*.7];
      
        self.font = bFont(15);
        self.textColor = kColorBlack;
        self.textAlignment = NSTextAlignmentLeft;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)turnSmall{
    self.font = bFont(12);
    self.textColor = kColorGray;
}

@end
