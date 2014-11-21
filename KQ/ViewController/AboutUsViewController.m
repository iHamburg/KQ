//
//  AboutUsViewController.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AboutUsViewController.h"
#import "CooperateViewController.h"

@interface AboutUsViewController ()

@end

#define headerHeight 194.0

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我们";
    self.config =  [[TableConfiguration alloc] initWithResource:@"AboutUsConfig"];
    
    self.globalMailComposer = [[MFMailComposeViewController alloc] init];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return headerHeight;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];

    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_w/2 - 42, 44, 85, 85)];
    imgV.image = [UIImage imageNamed:@"quickquan_launcher.png"];
    imgV.layer.cornerRadius = 5;
    imgV.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+10, _w, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"快券 1.0";
    label.font = nFont(15);
    label.textColor = kColorGray;
    
    [v addSubview:imgV];
    [v addSubview:label];
    
    return v;
}

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
#pragma mark - Mail
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:^{
        self.globalMailComposer = nil;
        self.globalMailComposer =  [[MFMailComposeViewController alloc] init];

    }];
}

- (IBAction)feedbackPressed:(id)sender{
    [self showFeedback];
}
- (IBAction)cooperatePressed:(id)sender{
    [self pushCooperate];
}

- (void)showFeedback{
    L();
    MFMailComposeViewController* mailPicker = self.globalMailComposer;
    mailPicker.mailComposeDelegate = self;
    
//    [mailPicker setMessageBody:@"haha" isHTML:YES];
    [mailPicker setSubject:@"意见反馈"];
    [mailPicker setToRecipients:@[@"app@quickquan.com"]];

    
    [self presentViewController:mailPicker animated:YES completion:nil];

}
- (void)pushCooperate{
    
    CooperateViewController *vc = [[CooperateViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
