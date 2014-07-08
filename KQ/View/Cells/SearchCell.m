//
//  SearchCell.m
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SearchCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation SearchCell

- (void)layoutSubviews{
//    [super layoutSubviews];
    self.imageView.frame = CGRectMake(13, 10, 50, 50);
    self.textLabel.frame = CGRectMake(70, 0, 200, 40);
    self.detailTextLabel.frame = CGRectMake(70, 32, 200, 30);
    self.accessoryView.frame = CGRectMake(200, 40, 30, 30);
    self.imageView.layer.cornerRadius = 3;
    self.imageView.layer.masksToBounds = YES;
}
@end
