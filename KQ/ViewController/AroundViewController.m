//
//  AroundViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AroundViewController.h"

#import "CouponDetailsViewController.h"

#import <CoreLocation/CoreLocation.h>




@interface AroundViewController (){
    
}

@end

@implementation AroundViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"附近";
    
    
    
    self.config = [[TableConfiguration alloc] initWithResource:@"AroundConfig"];
 
    self.isLoadMore = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toCouponDetails:(Coupon*)coupon{
//    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
//    vc.view.alpha = 1;
//    vc.coupon = coupon;
//    
//     [_root addNavVCAboveTab:vc];

    [_root toCouponDetails:coupon];
}

@end
