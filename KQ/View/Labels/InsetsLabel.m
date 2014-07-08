//
//  InsetsLabel.m
//  GSMA
//
//  Created by AppDevelopper on 14-4-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "InsetsLabel.h"

@implementation InsetsLabel



- (id)initWithFrame:(CGRect)frame insets:(UIEdgeInsets)insets{

    if (self = [self initWithFrame:frame]) {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect{
    
     [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _insets)];

}
@end
