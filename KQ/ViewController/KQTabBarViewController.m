//
//  KQTabBarViewController.m
//  KQ
//
//  Created by Forest on 14-9-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQTabBarViewController.h"
#import "KQRootViewController.h"


@interface KQTabBarViewController ()

@end

@implementation KQTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mainVC = [[MainViewController alloc] init];
    _aroundVC = [[AroundViewController alloc] init];
    _searchVC = [[KQSearchViewController alloc] init];
    _userCenterVC = [[UserCenterViewController alloc] init];
    self.delegate = self;
    
    NSArray *vcs = @[_mainVC,_aroundVC,_searchVC,_userCenterVC];
    NSMutableArray *tabVCs = [NSMutableArray array];
    for (UIViewController *vc in vcs) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [tabVCs addObject:nav];
    }
    
    self.viewControllers = [tabVCs copy];
    
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabbarController

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UINavigationController *)viewController{
    //    L();
    
    if (![[UserController sharedInstance] isLogin]) {
      
        
        UIViewController *rootVC = [viewController.viewControllers firstObject];
        if ([rootVC isKindOfClass:[UserCenterViewController class]]){
            
            [[KQRootViewController sharedInstance] toLogin];
            return NO;
        }
        else
            return YES;
    }
    return YES;
}

//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    
//    
//}


@end
