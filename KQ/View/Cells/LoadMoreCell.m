//
//  LoadMoreCell.m
//  Makers
//
//  Created by AppDevelopper on 14-5-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
//
    self.textLabel.text = @"载入更多";
}

@end
