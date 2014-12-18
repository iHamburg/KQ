//
//  InstructionView.m
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "InstructionView.h"

@implementation InstructionView


- (void)setImgNames:(NSArray *)imgNames{
    _imgNames = imgNames;
    
    int numOfPages = [imgNames count];
    _pageControl.numberOfPages = numOfPages;
    
    float width = self.width;
    float height = self.height;
    for (int i = 0; i<numOfPages; i++) {
        
        NSString *imgName = imgNames[i];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];
        
        imgV.image = [UIImage imageNamed:imgName];
        
        if (i < numOfPages - 1) {
            imgV.contentMode = UIViewContentModeCenter;
            
        }
        else{
            //最后一张图是顶头
            imgV.contentMode = UIViewContentModeTop;
            
        }
        
        [_scrollView addSubview:imgV];
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imgV.frame), 0);
        
        
        
        if (i == numOfPages -1 ) {
            float y = _h-50;
            
            if (!isPhone4) {
                y = _h - 100;
            }
            
            _backB.center = CGPointMake(imgV.center.x, y);
            [_scrollView addSubview:_backB];
        }
    }
    
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _backB = [UIButton buttonWithFrame:CGRectMake(0, 0, 113, 32) title:nil bgImageName:@"guide_finish.png" target:self action:@selector(buttonClicked:)];
        _backB.layer.borderColor = [UIColor whiteColor].CGColor;
        _backB.layer.borderWidth = 1;
        _backB.layer.cornerRadius = 2;
        
   
        
    }
    
    
    return self;
}


@end
