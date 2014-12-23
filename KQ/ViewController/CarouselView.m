//
//  CarouselView.m
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView

- (int)numOfPages{
    return [_imgNames count];
}

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
        
       
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
     
        CGFloat hPageControl = (!isPhone4)?100:20;
        float height = frame.size.height;
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height - hPageControl, _w, hPageControl)];
        
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = kColorGray;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];

        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
    }
    
    
    return self;
}

- (void)dealloc{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
#pragma mark - ScrollView & PageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat xOffset = scrollView.contentOffset.x;
    int page = xOffset/scrollView.width;
    _pageControl.currentPage = page;
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
    if (sender == _backB) {
        
        [self back];
    }
}

#pragma mark - Fcns
- (void)scrollToNextPage{
    
    CGFloat xOffset = _scrollView.contentOffset.x;
    int page = xOffset/_scrollView.width;
    
    int nextPage = page+1;
    if(nextPage >= self.numOfPages)
        nextPage = 0;
    
    [_scrollView setContentOffset:CGPointMake(nextPage*_scrollView.width, 0) animated:YES];
    _pageControl.currentPage = nextPage;
    
    [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:_scrollInterval];

    
}

- (void)reset{
    _scrollView.contentOffset = CGPointMake(0, 0);
    _pageControl.currentPage = 0;
}

- (void)back{
    [self removeFromSuperview];
}

@end
