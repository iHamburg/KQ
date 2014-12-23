//
//  UserSettingsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "ButtonCell.h"
#import "SwitchCell.h"

@interface UserSettingsViewController ()

@end

@implementation UserSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserSettingsConfig"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (void)initConfigCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[SwitchCell class]]) {
        
        UISwitch *aSwitch = cell.value;
        [aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
  
        aSwitch.on = _userController.people.isNotification;
        
    }
    else if ([cell isKindOfClass:[ButtonCell class]]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    
}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
//
//    if ([cell isKindOfClass:[SwitchCell class]]) {
//
//        UISwitch *aSwitch = cell.value;
//        [aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//        
//        aSwitch.on = _userController.people.isNotification;
//        
//    }
//    else if ([cell isKindOfClass:[ButtonCell class]]) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//    }
}


- (IBAction)versionPressed:(id)sender{
    [self checkVersion];
}

- (IBAction)switchChanged:(id)sender{
    
    UISwitch *aSwitch = sender;
    _userController.people.isNotification = aSwitch.isOn;
    [_userController savePeople:_userController.people];
}

- (void)checkVersion{
    L();
    NSString *appId = @"942472995";


    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/de/app/id%@&mt=8",appId];
    NSURL *url = [NSURL URLWithString: [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF16StringEncoding]];
    
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
