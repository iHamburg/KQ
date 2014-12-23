//
//  CarouselView.h
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView<UIScrollViewDelegate>{
    
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    UIButton *_backB;
    
    NSArray *_imgNames;
    float _scrollInterval;
    int _currentPage;
    
}

@property (nonatomic, strong) NSArray *imgNames;
@property (nonatomic, assign) float scrollInterval;
@property (nonatomic, readonly) int numOfPages;
@property (nonatomic, copy) void(^pageClickedBlock)(int);
@property (nonatomic, copy) void(^backBlock)();

- (IBAction)buttonClicked:(id)sender;

- (void)scrollToNextPage;
- (void)reset;
- (void)back;
@end
