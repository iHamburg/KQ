//
//  InstructionViewController.h
//  MyPhotoAlbum
//
//  Created by AppDevelopper on 16.09.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UtilLib.h"


@interface InstructionViewController : UIViewController<UIScrollViewDelegate>{

    UIButton *backB;
	UIPageControl *pageControl;
    UIScrollView *scrollView;
    
    NSArray *_imgNames;
    int numOfPages;
    

}


@property (nonatomic, strong) NSArray *imgNames;


@end
