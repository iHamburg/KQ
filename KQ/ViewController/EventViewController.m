//
//  EventViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-9-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "EventViewController.h"
#import "KQRootViewController.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];

    if (isPhone5) {
        self.bgV.image = [UIImage imageNamed:@"event_1136.jpg"];
    }
    else{
        self.bgV.image = [UIImage imageNamed:@"event.jpg"];
    }

//    self.bgV.userInteractionEnabled = YES;
//    
//    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];

    [self.view addSubview:self.bgV];
    
    [self performBlock:^{

        self.bgV.userInteractionEnabled = YES;
        
        [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        
    } afterDelay:3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)handleTap:(id)sender{
    L();
    
    self.back();
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
