//
//  TagsView.m
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TagsView.h"

@implementation TagsView

- (void)setTitles:(NSArray *)titles{

    for (int i = 0; i<titles.count; i++) {
        UIButton *b = _buttons[i];
        [b setTitle:titles[i] forState:UIControlStateNormal];
    }
}

// height: 45
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)awakeFromNib{
    
    _buttons = @[_b1,_b2,_b3];
    
    for (int i = 0; i<3; i++) {
        UIButton *button = _buttons[i];
        button.layer.borderColor = kColorYellow.CGColor;
        button.layer.borderWidth = 2;
        button.layer.cornerRadius = 5;

    }
    
}

- (IBAction)buttonPressed:(UIButton*)sender{
    
    _selectBlock(sender.tag);
}

@end
