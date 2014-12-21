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
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//#import "InteractiveButton.h"


@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _couponManager = [CouponManager sharedInstance];
    
    
    self.bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    NSString *imgName = @"event_bg.jpg";
    if (isPhone4) {
        imgName = @"event_bg_960.jpg";
    }
    
    self.couponId = [[NSUserDefaults standardUserDefaults] stringForKey:@"eventCouponId"];
    self.bgImgUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"eventBgImgUrl"];
    self.buttonImgUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"eventButtonImgUrl"];
    
    if (!self.couponId) {
        self.couponId = @"39";
    }
    
    if (!self.bgImgUrl) {
        self.bgV.image = [UIImage imageNamed:imgName];
    }
    else{
        [self.bgV setImageWithURL:[NSURL URLWithString:self.bgImgUrl]];
    }
    
    self.bgV.contentMode = UIViewContentModeScaleAspectFill;
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
    float y = _h*.8;
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(94, y, 132, 38)];
    
    if (!self.buttonImgUrl) {
        [self.button setBackgroundImage:[UIImage imageNamed:@"eventBtn.png"] forState:UIControlStateNormal];
    }
    else{
        [self.button setBackgroundImageWithURL:[NSURL URLWithString:self.buttonImgUrl]];
    }
    
    [self.button addTarget:self action:@selector(eventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    _coupon = [Coupon eventCoupon];
    
    
    
    [self.view addSubview:self.bgV];
    [self.view addSubview:self.button];

    NetworkClient *networkClient = [NetworkClient sharedInstance];
    __weak EventViewController *vc = self;
    [networkClient queryEventWithBlock:^(id object, NSError *error) {
        
//        NSLog(@"object # %@",object);
        NSDictionary *dict = object[@"event"];
        vc.couponId = dict[@"id"];
        vc.bgImgUrl = dict[@"imgUrl"];
        vc.buttonImgUrl = dict[@"buttonUrl"];
        
        [[NSUserDefaults standardUserDefaults] setObject:vc.couponId forKey:@"eventCouponId"];
        [[NSUserDefaults standardUserDefaults] setObject:vc.bgImgUrl forKey:@"eventBgImgUrl"];
        [[NSUserDefaults standardUserDefaults] setObject:vc.buttonImgUrl forKey:@"eventButtonImgUrl"];
        

    }];

 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



- (IBAction)handleTap:(id)sender{

    [self back];
}

- (IBAction)eventButtonClicked:(id)sender{

    [self toCouponDetails];
}

#pragma mark - Fcns

    // 进首页
- (void)back{
    L();

    [self.view removeFromSuperview];
}

- (void)toCouponDetails{
    
    
    Coupon *coupon = [Coupon new];
    coupon.id = self.couponId;
    
    [[KQRootViewController sharedInstance] toCouponDetails:coupon];
    
    [self.view removeFromSuperview];
}


@end
