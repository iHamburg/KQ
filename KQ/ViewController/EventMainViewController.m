//
//  EventMainViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-9-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "EventMainViewController.h"

@interface EventMainViewController ()

@end

@implementation EventMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     self.config = [[TableConfiguration alloc] initWithResource:@"mainConfig"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)cityPressed:(id)sender{
    L();
    
//    [self performSegueWithIdentifier:@"toCity" sender:nil];
}



@end
