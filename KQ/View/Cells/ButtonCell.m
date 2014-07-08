//
//  ButtonCell.m
//  Makers
//
//  Created by AppDevelopper on 14-5-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)layoutSubviews{
    

    self.textLabel.frame = self.bounds;
}



@end
