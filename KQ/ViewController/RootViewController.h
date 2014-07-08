//
//  RootViewController.h
//  Test
//
//  Created by AppDevelopper on 14-4-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//
//!!!:REUSE

#import <UIKit/UIKit.h>
#import "UtilLib.h"

@interface RootViewController : UITabBarController{

     BOOL rootLoadViewFlag;
    NSMutableArray *testObjs;

}


+ (id)sharedInstance;

- (void)registerNotification;
- (void)handleAppFirstTimeOpen;
- (void)handleRootFirstDidAppear;

//inherit
- (void)test;
- (void)testViewController:(NSString*)className;
- (void)testNav:(NSString*)className;
@end
