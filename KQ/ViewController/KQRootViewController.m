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
    
//    L();
    
    self.delegate = self;
   
    UITabBar *tabBar = self.tabBar;
    [tabBar setTintColor:[UIColor colorWithRed:252.0/255 green:81.0/255 blue:32.0/255 alpha:1]];
    [tabBar setBarTintColor:[UIColor whiteColor]];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    [tabBarItem1 setImage:[UIImage imageNamed:@"icon-index01.png"]];
    [tabBarItem2 setImage:[UIImage imageNamed:@"icon-nearby01.png"]];
    [tabBarItem3 setImage:[UIImage imageNamed:@"icon-search01.png"]];
    [tabBarItem4 setImage:[UIImage imageNamed:@"icon-user01.png"]];
    
     [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"icon-index02.png"]];
     [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"icon-nearby02.png"]];
     [tabBarItem3 setSelectedImage:[UIImage imageNamed:@"icon-search02.png"]];
     [tabBarItem4 setSelectedImage:[UIImage imageNamed:@"icon-user02.png"]];
    
    [tabBarItem2 setTitle:@"附近"];
    [tabBarItem3 setTitle:@"搜索"];
    [tabBarItem4 setTitle:@"我的"];
    

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
    
    [super handleRootFirstWillAppear];
    

    if (kIsMainApplyEvent) {
        [self performSegueWithIdentifier:@"toEvent" sender:self];
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
    else if([segue.identifier isEqualToString:@"toEvent"]){
        
        
        _eventVC = segue.destinationViewController;
        
        __weak id vc = self;
        _eventVC.back = ^{
            
            [(KQRootViewController*)vc removeEvent];
            
        };
    }
}
#pragma mark - TabbarController

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UINavigationController *)viewController{
//    L();
    
    UIViewController *rootVC = [viewController.viewControllers firstObject];
    
    if ([rootVC isKindOfClass:[UserCenterViewController class]] && ![[UserController sharedInstance] isLogin]) {
        
        [self toLogin];
        
        return NO;
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    
}



#pragma mark - Fcns

- (void)startEvent{
    
    //判断是否登录
    
    if ([[UserController sharedInstance] isLogin]) {
        NSLog(@" is login");
    }
    else{
        NSLog(@" isn't login ");
    }
    
}


- (IBAction)toLogin {

    [self performSegueWithIdentifier:@"toLogin" sender:self];
}




- (void)didLogin{
//    self.selectedIndex = 3;
    
}
- (void)didLogout{

    self.selectedIndex = 0;
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
