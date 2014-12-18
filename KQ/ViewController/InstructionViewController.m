//
//  InstructionViewController.m
//  MyPhotoAlbum
//
//  Created by AppDevelopper on 16.09.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "InstructionViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface InstructionViewController ()

@end

@implementation InstructionViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];

    numOfPages = 4;
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;

    backB = [UIButton buttonWithFrame:CGRectMake(0, 0, 113, 32) title:nil bgImageName:@"guide_finish.png" target:self action:@selector(buttonClicked:)];
    backB.layer.borderColor = [UIColor whiteColor].CGColor;
    backB.layer.borderWidth = 1;
    backB.layer.cornerRadius = 2;
  
    		for (int i = 0; i<numOfPages; i++) {
    
                NSString *imgName = [NSString stringWithFormat:@"instruction0%d.png",i+1];
    			UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(_w*i, 0, _w, _h)];
             
                imgV.image = [UIImage imageNamed:imgName];
    
                if (i < numOfPages - 1) {
                    imgV.contentMode = UIViewContentModeCenter;

                }
                else{
                    //最后一张图是顶头
                    imgV.contentMode = UIViewContentModeTop;

                }
                
    			[scrollView addSubview:imgV];
                scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imgV.frame), 0);
                

                
    			if (i == numOfPages -1 ) {
                    float y = _h-50;
                   
                    if (!isPhone4) {
                        y = _h - 100;
                    }
                    
                    backB.center = CGPointMake(imgV.center.x, y);
                    [scrollView addSubview:backB];
    			}
    		}
    
        
    CGFloat hPageControl = (!isPhone4)?100:20;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _h - hPageControl, _w, hPageControl)];
    pageControl.numberOfPages = numOfPages;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = kColorGray;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];

    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];

}

- (void)viewDidAppear:(BOOL)animated{
	L();
	[super viewDidAppear:animated];
	
}

- (void)dealloc{
    L();
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
	if (sender == backB) {
 
        [self.view removeFromSuperview];

	}
}

#pragma mark - ScrollView & PageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView_{
	CGFloat xOffset = scrollView.contentOffset.x;
	int page = xOffset/scrollView.width;
	pageControl.currentPage = page;
}

@end
