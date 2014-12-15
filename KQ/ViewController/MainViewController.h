//
//  MainViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"
#import "TutorialView.h"

@interface MainViewController : NetTableViewController{


}

@property (nonatomic, strong) TutorialView *tutorialV;

- (IBAction)handleBannerTap:(id)sender;


- (void)toCouponDetails:(id)couponModel; /// root addNavVCAboveTab
- (void)addTutorial;

@end
