//
//  RootViewController.h
//  Test
//
//  Created by AppDevelopper on 14-4-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UtilLib.h"

@interface RootViewController : UIViewController{

    BOOL rootLoadViewFlag;
    
    NSMutableArray *testObjs;

}


+ (id)sharedInstance;

- (void)registerNotification;
- (void)handleAppFirstTimeOpen;
- (void)handleRootFirstWillAppear;

//inherit
- (void)test;
- (void)testViewController:(NSString*)className;
- (void)testNav:(NSString*)className;
@end
