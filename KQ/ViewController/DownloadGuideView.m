//
//  DownloadGuideView.m
//  KQ
//
//  Created by Forest on 14-12-18.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DownloadGuideView.h"

@implementation DownloadGuideView



- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _backB = [UIButton buttonWithFrame:CGRectMake(0, 0, 170, 48) title:nil bgImageName:@"btn-step04-shop.png" target:self action:@selector(buttonClicked:)];
        
        
    }
    
    
    return self;
}

- (void)back{
    self.backBlock();
}

#pragma mark - IBAction
- (IBAction)handleTap:(id)sender{
    L();
    
    if (_pageControl.currentPage == self.numOfPages - 1) {
        [self back];
        //        [self back];
    }
    
}
- (IBAction)buttonClicked:(id)sender{
    if (sender == _backB) {
        
        self.pageClickedBlock(self.numOfPages-1);
    }
}

@end
