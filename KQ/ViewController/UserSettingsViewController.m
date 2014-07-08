//
//  UserSettingsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "ButtonCell.h"

@interface UserSettingsViewController ()

@end

@implementation UserSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserSettingsConfig"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    if ([cell isKindOfClass:[ButtonCell class]]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.row == 0) {
//        [UIAlertView showAlert:@"现在是测试版本v0.2" msg:nil cancel:@"OK"];
//    }
//    else{
//        [UIAlertView showAlert:@"快券APP" msg:nil cancel:@"OK"];
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
