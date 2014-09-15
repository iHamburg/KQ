//
//  InsetsTextField.m
//  GSMA
//
//  Created by AppDevelopper on 14-4-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField



- (id)initWithFrame:(CGRect)frame offset:(UIOffset)offset{

    if (self = [self initWithFrame:frame]) {
        self.offset = offset;
    }
    return self;
}

// 用来设置placeholder！
//- (CGRect)textRectForBounds:(CGRect)bounds {
//
////    return CGRectInset( bounds , _offset.horizontal , _offset.vertical );
//
////    return CGRectInset( bounds , 60 , 0 );
//}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 60 , 0 );
    
//    return CGRectInset( bounds , _offset.horizontal , _offset.vertical );

//     return CGRectInset( bounds , _offset.horizontal , _offset.vertical );
}

@end
