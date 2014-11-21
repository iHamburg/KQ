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
#import "InstructionViewController.h"

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


- (UITabBar*)tabBar{
    return _tabVC.tabBar;
}

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


- (void)handleAppFirstTimeOpen{
    L();
    [self showInstruction];
}

- (void)handleRootFirstWillAppear{
    
    L();
    
    
    
//    [self startEvent];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerNotification{
    [super registerNotification];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kNotificationLogin object:nil queue:nil usingBlock:^(NSNotification *note) {
   
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

- (void)showInstruction{
    self.instructionVC = [[InstructionViewController alloc] init];
    
    [self.view addSubview:self.instructionVC.view];
}

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


//从main， 附近进couponDetails
- (void)toCouponDetails:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
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


    
}

- (void)loginWithBlock:(BooleanResultBlock)block{
    
    
}

- (void)presentLoginWithMode:(PresentMode)mode;{
    KQLoginViewController *vc = [[KQLoginViewController alloc] init];
    vc.view.alpha = 1;  //提前先load LoginVC，生成back，这样之后的back的selector能覆盖默认的back
    
    
    [self presentNav:vc mode:mode];
    
}


- (void)toTab:(int)index{

    _tabVC.selectedIndex = 0;
    
}

- (void)presentNav:(UIViewController*)vc mode:(PresentMode)mode{
    
    self.presentMode = mode;
    
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(dismissNav)]];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];

}


- (void)dismissNav{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // 把presentMode调回default
        self.presentMode = PresentDefault;
    }];
}

- (void)addNav:(UIViewController*)vc{
    
}

- (void)test{
    L();
    
    [super test];
    
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];

//    [self showInstruction];
 //    [self testNav:@"AddCardViewController"];
    
//    CGRect r = [UIScreen mainScreen].bounds;
//    NSLog(@"screen # %@",NSStringFromCGRect(r));
//    r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
//        NSLog(@"screen # %@",NSStringFromCGRect(r));
    

//    [self testNav:@"ChangePasswordViewController"];

//    [self testNav:@"KQRegisterViewController"];
}



@end
