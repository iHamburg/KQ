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
    
    
    self.bgV.image = [UIImage imageNamed:@"bg-landingpage.jpg"];
    self.bgV.contentMode = UIViewContentModeTop;
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    

//    self.button = [InteractiveButton buttonWithFrame:CGRectMake(85, _h - 64, 150, 44) title:nil bgImageName:@"btn-receive.png" target:self action:@selector(eventButtonClicked:)];
    self.button = [[InteractiveButton alloc] initWithFrame:CGRectMake(85, _h - 64, 150, 44)];
    [self.button setBackgroundImage:[UIImage imageNamed:@"btn-receive.png"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(eventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    
    self.coupon = [[Coupon alloc] init];
    self.coupon.id = @"38";
    self.coupon.avatarUrl = @"http://www.quickquan.com/images/moti_coupon.jpg";
    self.coupon.discountContent = @"0元享18元套餐";
    self.coupon.usage = @"新用户注册即可0元享受，价值18元的美味摩提2个！榴莲慕思摩提、蓝莓味摩提香甜好味、松软曼妙口感！30家店通用";
    
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

//    self.toEventCoupon(self.coupon);

    [self.button startLoading];
//    [self toCouponDetails];
}

#pragma mark - Fcns

- (void)back{
    L();
    [self.view removeFromSuperview];
}

- (void)toCouponDetails{
    
    [[KQRootViewController sharedInstance] toCouponDetails:self.coupon];
    
    [self.view removeFromSuperview];
}


@end
