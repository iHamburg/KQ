//
//  AddSegue.m
//  KQ
//
//  Created by AppDevelopper on 14-9-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AddSegue.h"

@implementation AddSegue

- (void)perform{
    
    UIViewController *current = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    [current.view addSubview:destination.view];
}

@end
