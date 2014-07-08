//
//  TextViewCell.m
//  Makers
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TextViewCell.h"

@interface TextViewCell (){
    UITextView *_tv;
    UIButton *_button;
}

@end

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _tv = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, 240, 52)];
        _tv.text = @"评论";
        _tv.layer.borderColor = kColorLightGray.CGColor;
        _tv.layer.borderWidth = 1;
        _tv.layer.cornerRadius = 2;
        _tv.delegate = self;
        
        _button = [[UIButton alloc] initWithFrame:CGRectMake(270, 10, 48, 25)];
        [_button setTitle:@"评论" forState:UIControlStateNormal];
        [_button setBackgroundColor:kColorGreen];
        _button.titleLabel.font = [UIFont fontWithName:kFontName size:12];
        _button.layer.cornerRadius = 2;
        [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:_tv];
        [self.contentView addSubview:_button];
    }
    return self;
}


- (void)layoutSubviews{}

- (void)closeTextView{
    [_tv resignFirstResponder];
}

- (IBAction)buttonPressed:(id)sender{
    [_tv resignFirstResponder];
}

@end
