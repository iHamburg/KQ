//
//  ButtonCell.m
//  Makers
//
//  Created by AppDevelopper on 14-5-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell


- (void)load{
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews{
    
    self.textLabel.frame = self.bounds;
}



@end
