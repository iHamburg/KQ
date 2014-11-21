//
//  CooperateViewController.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CooperateViewController.h"

@interface CooperateViewController ()

@end

@implementation CooperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商户合作";
    
    self.config =  [[TableConfiguration alloc] initWithResource:@"CooperateConfig"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}


- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (IBAction)callPressed:(id)sender{
    
    [self call];
}

- (void)call{
//    L();
    
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"021-65218745"];
   
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
