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
    
    if (![[UserController sharedInstance] isLogin]) {
        [self showEvent];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerNotification{
    [super registerNotification];
  
}


#pragma mark - IBAction
- (IBAction)removeNavPressed:(id)sender{
    [self removeNavVCAboveTab];
}



#pragma mark - Fcns

- (void)showInstruction{
    self.instructionVC = [[InstructionViewController alloc] init];
    
    [self.view addSubview:self.instructionVC.view];
}

- (void)showEvent{
    
    _eventVC = [[EventViewController alloc] init];
    
    [self.view insertSubview:_eventVC.view aboveSubview:_tabVC.view];
    
}


//从main， 附近进couponDetails
- (void)toCouponDetails:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
   
    [self addNavVCAboveTab:vc];

}


- (void)presentLoginWithBlock:(BooleanResultBlock)block{
    KQLoginViewController *vc = [[KQLoginViewController alloc] init];
    
    vc.view.alpha = 1;  //提前先load LoginVC，生成back，这样之后的back的selector能覆盖默认的back
    // 这里的block可以放在root，让root有一个bool值的block
    vc.successBlock = block;
    
    [self presentNav:vc];
}

- (void)toTab:(int)index{

    _tabVC.selectedIndex = 0;
    
}

- (void)presentNav:(UIViewController*)vc{
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_white_back.png" target:self action:@selector(dismissNav)]];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];

}

- (void)presentNav:(UIViewController *)vc block:(BooleanResultBlock)block{
    
    self.presentBlock = block;
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_white_back.png" target:self action:@selector(dismissNav)]];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];

}



- (void)addNavVCAboveTab:(UIViewController *)vc{
    
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_white_back.png" target:self action:@selector(removeNavPressed:)]];
    
    _nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [_nav.view setOrigin:CGPointMake(_w, 0)];
    [self.view addSubview:_nav.view];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_nav.view setOrigin:CGPointMake(0, 0)];
        
    } completion:^(BOOL finished) {
        
    }];

}

- (void)removeNavVCAboveTab{
    
  
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_nav.view setOrigin:CGPointMake(_w, 0)];
        
    } completion:^(BOOL finished) {
          [_nav.view removeFromSuperview];
        _nav = nil;
    }];

}

- (void)dismissNav{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        // 把presentMode调回default
//        self.presentMode = PresentDefault;
    }];
}

//- (void)addNav:(UIViewController*)vc{
//    
//}

- (void)test{
    L();
    
    [super test];
    
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];

    // 版本号

    
    
//    NSLog(@"uniqueIdentifier: %@", [[UIDevice currentDevice] uniqueIdentifier]);

//    NSLog(@"systemVersion: %@", [[UIDevice currentDevice] systemVersion]);
//    NSLog(@"model: %@", [[UIDevice currentDevice] model]);
// 
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSLog(@"app version # %@",app_build);
//    [self showEvent];
//    [self showInstruction];
//     [self testNav:@"ChangePasswordViewController"];
    
//    CGRect r = [UIScreen mainScreen].bounds;
//    NSLog(@"screen # %@",NSStringFromCGRect(r));
//    r = CGRectApplyAffineTransform(r, CGAffineTransformMakeRotation(90 * M_PI / 180.));
//        NSLog(@"screen # %@",NSStringFromCGRect(r));
    

//    [self testNav:@"ChangePasswordViewController"];

//    [self testNav:@"KQRegisterViewController"];
    
}



@end
