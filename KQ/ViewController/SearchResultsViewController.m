//
//  SearchResultsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SearchResultsViewController.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索结果";
    
    self.isLoadMore = NO;
    
    self.config = [[TableConfiguration alloc] initWithResource:@"AroundConfig"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
