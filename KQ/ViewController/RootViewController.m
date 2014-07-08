//
//  RootViewController.m
//  Test
//
//  Created by AppDevelopper on 14-4-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

- (void)test;

@end

@implementation RootViewController

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    rootLoadViewFlag = YES;
    
    [self registerNotification];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    NSLog(@"willappear root # %@",self.view);
    
    if (rootLoadViewFlag) {
        
        rootLoadViewFlag = NO;
        
        [self handleRootFirstDidAppear];
        
		if (isFirstOpen) {
			
			[self handleAppFirstTimeOpen];
			
		}
		else if(isUpdateOpen){
			
		}
        
   
	}
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleAppFirstTimeOpen{}
- (void)handleRootFirstDidAppear{}


- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillEnterForeground)
												 name:UIApplicationWillEnterForegroundNotification
											   object: [UIApplication sharedApplication]];
	
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWillResignActive) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    
    
}

- (void)handleWillEnterForeground{}

- (void)handleWillResignActive{
}

- (void)testViewController:(NSString*)className{
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [testObjs addObject:vc];
    [self.view addSubview:vc.view];
}

- (void)testNav:(NSString*)className{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(className) alloc] init]];
    nav.view.frame = self.view.bounds;
    
    [testObjs addObject:nav];
    
    [self.view addSubview:nav.view];
}


- (void)test{
    
//    L();
    
    testObjs = [NSMutableArray array];
}
@end
