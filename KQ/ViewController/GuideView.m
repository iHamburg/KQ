//
//  TutorialView.m
//  KQ
//
//  Created by Forest on 14-12-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "GuideView.h"


@implementation GuideView


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
        
        imgV.contentMode = UIViewContentModeCenter;
        
        [_scrollView addSubview:imgV];
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imgV.frame), 0);
        
        
        
        if (i == numOfPages -1 ) { // 最后一页
            float y = _h-50;
            
            if (!isPhone4) {
                y = _h - 100;
            }
            
            UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(275, 15, 30, 30)];
            iconV.image = [UIImage imageNamed:@"btn-step04-close.png"];
            [imgV addSubview:iconV];
            
            _backB.center = CGPointMake(imgV.center.x, y);
            [_scrollView addSubview:_backB];
        }
    }
    
}


- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _backB = [UIButton buttonWithFrame:CGRectMake(0, 0, 170, 48) title:nil bgImageName:@"btn-step04-start.png" target:self action:@selector(buttonClicked:)];


        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = kColorYellow;
        
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        
    }
    
    
    return self;
}


#pragma mark - IBAction
- (IBAction)handleTap:(id)sender{
    L();
   
    if (_pageControl.currentPage == self.numOfPages - 1) {
        [self removeFromSuperview];
    }
 
}



- (void)back{
    
    self.pageClickedBlock(self.numOfPages - 1);
    [self removeFromSuperview];
}
@end
