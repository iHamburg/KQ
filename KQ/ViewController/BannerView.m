//
//  BannerView.m
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+WebCache.h"

@implementation BannerView


- (void)setImgNames:(NSArray *)imgNames{
    _imgNames = imgNames;
    
    int numOfPages = [imgNames count];
    _pageControl.numberOfPages = numOfPages;
    
    float width = self.width;
    float height = self.height;
    for (int i = 0; i<numOfPages; i++) {
        
        NSString *imgName = imgNames[i];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];
        imgV.userInteractionEnabled = YES;
        imgV.tag = i;
        [imgV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)]];
        
        [imgV setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        

            imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        [_scrollView addSubview:imgV];
        
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imgV.frame), 0);
        
   
    }
    
}



- (void)setScrollInterval:(float)scrollInterval{
    _scrollInterval = scrollInterval;
    
    [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:_scrollInterval];
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
      
        CGFloat hPageControl = 20;
        float height = frame.size.height;
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height - hPageControl, _w, hPageControl)];
        
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = kColorGray;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        [self addSubview:_pageControl];
        
    }
    
    
    return self;
}

#pragma mark - IBAction
- (IBAction)handleTap:(UITapGestureRecognizer*)sender{
    L();
    int index = sender.view.tag; // 0 - numOfPages-1
    self.pageClickedBlock(index);
}

@end
