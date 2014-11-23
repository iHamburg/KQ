//
//  AfterDownloadViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-9-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AfterDownloadViewController.h"
#import "AddCardViewController.h"

@interface AfterDownloadViewController ()

@end

@implementation AfterDownloadViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"放入我的快券";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    

    [_scrollView addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 55;
    }
    else
        return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int section  = (int)indexPath.section;
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
    
    if (section == 0) {
       UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(75, 11, 32, 32)];
        imgV.image = [UIImage imageNamed:@"icon-tip.png"];

        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 200, 55)];

        
        l.text = @"已成功放入\"我的快券\"";
        l.textColor = kColorYellow;
        l.textAlignment = NSTextAlignmentLeft;
        l.font = [UIFont fontWithName:kFontName size:14];
        
        [cell addSubview:imgV];
        [cell addSubview:l];
    }
    else{

        
    }
  
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 200)];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, _w, 30)];
    l.text = @"你没有支持快券使用的银行卡";
    l.textAlignment = NSTextAlignmentCenter;
    l.font = [UIFont fontWithName:kFontBoldName size:16];
    l.textColor = kColorRed;
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(l.frame)+10, _w - 20, 60)];
    l2.textColor = kColorDardGray;
    l2.text = @"您只需添加一张银行卡到\"我的银行卡\"开通 服务。即可现场刷卡，使用已下载的快券啦！";
    l2.font = [UIFont fontWithName:kFontBoldName size:12];
    l2.numberOfLines = 0;
    
    UIButton *b = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(l2.frame)+10, _w - 20, 35) title:@"+添加银行卡" bgImageName:nil target:self action:@selector(addButtonClicked:)];
    b.backgroundColor = [UIColor colorWithRed:30.0/255 green:175.0/255 blue:65.0/255 alpha:1];
    b.titleLabel.font = [UIFont fontWithName:kFontBoldName size:14];
    b.layer.cornerRadius = 3;
    
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(b.frame)+10, _w-20, 30)];
    l3.text = @"(限卡号62开头的银行卡)";
    l3.textColor = kColorGray;
    l3.font = [UIFont fontWithName:kFontName size:12];
    
    [v addSubview:l];
    [v addSubview:l2];
    [v addSubview:b];
    [v addSubview:l3];
    return v;
}

#pragma mark - IBAction

- (IBAction)addButtonClicked:(id)sender{
    [self toAddCard];
}

#pragma mark - Fcn
- (void)toAddCard{
    L();
    AddCardViewController *vc = [[AddCardViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    [_root presentNav:vc];

}


- (void)back{
    
    if (self.source == 0) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
