//
//  InsetsTextField.h
//  GSMA
//
//  Created by AppDevelopper on 14-4-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsTextField : UITextField{
    UIOffset _offset;
}

@property (nonatomic, assign) UIOffset offset;

- (id)initWithFrame:(CGRect)frame offset:(UIOffset)offset;

@end
