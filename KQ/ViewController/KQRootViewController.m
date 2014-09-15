//
//  KQRootViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRootViewController.h"
#import "SearchViewController.h"
#import "AVOSServer.h"
#import "NetworkClient.h"
#import "KQLoginViewController.h"
#import "UserCenterViewController.h"
#import "MainViewController.h"
#import "EventViewController.h"
#import "UserController.h"
#import "KQTabBarViewController.h"
#import "CouponDetailsViewController.h"
#import "KQLoginViewController.h"
    //#import "AfterDownloadViewController.h"
//#import "AfterDownloadBankViewController.h"


@interface KQRootViewController (){

    EventViewController *_eventVC;
    
}

@property (nonatomic, strong) IBOutlet EventViewController *eventVC;

- (void)removeEvent;

@end

@implementation KQRootViewController

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{

        sharedInstance = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    });
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    L();

    _tabVC = [[KQTabBarViewController alloc] init];
    
    [self.view addSubview:_tabVC.view];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    L();
    [super viewDidAppear:animated];
    
    
    [self test];
    
    
}

- (void)handleRootFirstWillAppear{
    
    L();
    
    [super handleRootFirstWillAppear];
    
    
    if (kIsMainApplyEvent) {
        
        [self startEvent];
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerNotification{
    [super registerNotification];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"toLogin" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self toLogin];
    }];
    
}


#pragma mark - IBAction
- (IBAction)backPressed:(id)sender{
    [self removeNavVCAboveTab];
}

#pragma mark - Fcns


- (void)addVCAboveTab:(UIViewController*)vc{

    [_tabVC.view addSubview:vc.view];

}


- (void)removeVCFromTab:(UIViewController *)vc{
    [vc.view removeFromSuperview];
}


- (void)addNavVCAboveTab:(UIViewController*)vc{
 
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [_tabVC.view addSubview:_nav.view];
    
    
    
}
- (void)removeNavVCAboveTab{
    
    [_nav.view removeFromSuperview];
    
}

#pragma mark - Fcns

- (void)startEvent{
    
    //判断是否登录
    
    if ([[UserController sharedInstance] isLogin]) {
        NSLog(@"user has login, go to mainPage");
        
       
    }
    else{
        NSLog(@"no user, show event Page");
        
        __weak id vc = self;
        
        _eventVC = [[EventViewController alloc] init];
        _eventVC.toEventCoupon = ^(Coupon* coupon){
        
            [vc toCouponDetails:coupon];

        };
        
        [self.view addSubview:_eventVC.view];
        
      
        
    }
    
}

- (void)removeEvent{
    [self.eventVC.view removeFromSuperview];
    self.eventVC = nil;
}

//点击banner
- (void)toCouponDetails:(Coupon*)coupon{
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self.view addSubview:_nav.view];
    
    
    [_eventVC.view removeFromSuperview];
}

/**
 **/
- (void)toLogin {

    KQLoginViewController *vc = [[KQLoginViewController alloc] init];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
    
    
}




- (void)didLogin{
//    self.selectedIndex = 3;
    
}
- (void)didLogout{

//    self.selectedIndex = 0;
    _tabVC.selectedIndex = 0;
}



- (void)test{
    L();
    
    [super test];
    
    [[AVOSServer sharedInstance] test];
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];

 
//    [self testNav:@"AddCardViewController"];

}

@end
