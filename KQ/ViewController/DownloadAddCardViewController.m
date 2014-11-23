//
//  DownloadAddCardViewController.m
//  KQ
//
//  Created by Forest on 14-11-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DownloadAddCardViewController.h"

@interface DownloadAddCardViewController ()

@end

@implementation DownloadAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [_libraryManager startHint:@"还需一步，即可下载成功！"];
}

@end
