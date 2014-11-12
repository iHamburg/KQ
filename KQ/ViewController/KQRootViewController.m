//
//  KQRootViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRootViewController.h"
#import "SearchViewController.h"

#import "NetworkClient.h"
#import "KQLoginViewController.h"
#import "UserCenterViewController.h"
#import "MainViewController.h"
#import "EventViewController.h"
#import "UserController.h"
#import "KQTabBarViewController.h"
#import "CouponDetailsViewController.h"
#import "KQLoginViewController.h"
#import "UserCouponsViewController.h"
#import "NSString+md5.h"

@interface KQRootViewController (){

    EventViewController *_eventVC;
    
}

@property (nonatomic, strong) IBOutlet EventViewController *eventVC;

- (void)addVCAboveTab:(UIViewController*)vc;
- (void)removeVCFromTab:(UIViewController *)vc;

- (void)addNavVCAboveTab:(UIViewController*)vc;
- (void)removeNavVCAboveTab;


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
    
    
    [self startEvent];
    
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
- (IBAction)removeNavPressed:(id)sender{
    [self removeNavVCAboveTab];
}

#pragma mark - Private Fcns


- (void)addVCAboveTab:(UIViewController*)vc{

    [_tabVC.view addSubview:vc.view];

}


- (void)removeVCFromTab:(UIViewController *)vc{
    [vc.view removeFromSuperview];
}


///??? 如果有多个vc叠加的话会怎么样？
- (void)addNavVCAboveTab:(UIViewController*)vc{
 
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(removeNavPressed:)]];
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
  
    [self.view addSubview:_nav.view];
    
    
    
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
        
        _eventVC = [[EventViewController alloc] init];

        [self.view addSubview:_eventVC.view];
        
      
        
    }
    
}


//点击banner
- (void)toCouponDetails:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(removeNavPressed:)]];
   
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];

    [_nav.view setOrigin:CGPointMake(_w, 0)];
    [self.view addSubview:_nav.view];
  
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_nav.view setOrigin:CGPointMake(0, 0)];
        
    } completion:^(BOOL finished) {
        
    }];
    

}

- (void)toMyCoupons{
    // 如果在toCouponDetails，先退出来
    [_nav.view removeFromSuperview];
    
    UserCouponsViewController *vc = [[UserCouponsViewController alloc] init];
    vc.view.alpha = 1;
    
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(removeNavPressed:)]];
    
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.view addSubview:_nav.view];
}

/**
 *
 **/
- (void)toLogin {

    KQLoginViewController *vc = [[KQLoginViewController alloc] init];
    vc.view.alpha = 1;
//    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(removeNavPressed:)]];
    
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];

//    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    
//    [_nav.view setOrigin:CGPointMake(_w, 0)];
//    [self.view addSubview:_nav.view];
//    
//    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        [_nav.view setOrigin:CGPointMake(0, 0)];
//        
//    } completion:^(BOOL finished) {
//        
//    }];

   
    
}




- (void)didLogout{

    _tabVC.selectedIndex = 0;
    
}



- (void)test{
    L();
    
    [super test];
    
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];

 //    [self testNav:@"AddCardViewController"];
    
//    CGRect r = [UIScreen mainScreen].bounds;
//    NSLog(@"screen # %@",NSStringFromCGRect(r));
//    r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
//        NSLog(@"screen # %@",NSStringFromCGRect(r));


}



@end
