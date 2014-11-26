//
//  EventViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-9-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "EventViewController.h"
#import "KQRootViewController.h"
#import "NetworkClient.h"
#import "InteractiveButton.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    self.bgV.image = [UIImage imageNamed:@"event_bg.jpg"];
    self.bgV.contentMode = UIViewContentModeTop;
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
    float y = _h*.8;
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(94, y, 132, 38)];
    [self.button setBackgroundImage:[UIImage imageNamed:@"eventBtn.png"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(eventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    _coupon = [Coupon eventCoupon];
    
    [self.view addSubview:self.bgV];
    [self.view addSubview:self.button];

 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



- (IBAction)handleTap:(id)sender{
 //   L();
    [self back];
}

- (IBAction)eventButtonClicked:(id)sender{

//    L();
    [self toCouponDetails];
}

#pragma mark - Fcns

    // 进首页
- (void)back{
    L();

    [self.view removeFromSuperview];
}

- (void)toCouponDetails{
    
    [[KQRootViewController sharedInstance] toCouponDetails:self.coupon];
    
    [self.view removeFromSuperview];
}


@end
