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
    
//    NSLog(@"root.subViews # %@",self.view.subviews);
    
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
        
        [self performSegueWithIdentifier:@"toLogin" sender:self];
    }];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toLogin"]){
        
    }
//    else if([segue.identifier isEqualToString:@"toEvent"]){
//        
//        
//        _eventVC = segue.destinationViewController;
//        
//        __weak id vc = self;
//        _eventVC.back = ^{
//            
//            [(KQRootViewController*)vc removeEvent];
//            
//        };
//    }
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
        
        _eventVC = [[EventViewController alloc] init];
        _eventVC.toEventCoupon = ^(Coupon* coupon){
        
            L();
        };
        
        [self.view addSubview:_eventVC.view];
        
      
        
    }
    
}




- (IBAction)toLogin {

//    [self performSegueWithIdentifier:@"toLogin" sender:self];
    
}




- (void)didLogin{
//    self.selectedIndex = 3;
    
}
- (void)didLogout{

//    self.selectedIndex = 0;
}

- (void)removeEvent{
    [self.eventVC.view removeFromSuperview];
    self.eventVC = nil;
}

- (void)test{
    L();
    
    [[AVOSServer sharedInstance] test];
    [[NetworkClient sharedInstance] test];
    [[UserController sharedInstance] test];

 
    

}

@end
