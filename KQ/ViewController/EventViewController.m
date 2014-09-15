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
    

    UIButton *button = [UIButton buttonWithFrame:CGRectMake(85, _h - 64, 150, 44) title:nil bgImageName:@"btn-receive.png" target:self action:@selector(eventButtonClicked:)];
    
    
    self.coupon = [[Coupon alloc] init];
    self.coupon.id = kEventCouponId;
    self.coupon.avatarUrl = @"http://www.quickquan.com/images/moti_coupon.jpg";
    self.coupon.discountContent = @"0元享18元套餐";
    
    [self.view addSubview:self.bgV];
    [self.view addSubview:button];

 
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
    self.toEventCoupon(self.coupon);
}


- (void)back{
    L();
    [self.view removeFromSuperview];
}



@end
