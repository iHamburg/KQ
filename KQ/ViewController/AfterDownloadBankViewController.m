//
//  AfterDownloadBankViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-9-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AfterDownloadBankViewController.h"
#import "KQRootViewController.h"

@interface AfterDownloadBankViewController (){
    NSArray *_imgNames;
}

@end

@implementation AfterDownloadBankViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"放入我的快券";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _w, 280) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    

    _scrollView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];

    _imgNames = @[@"card1.jpg",@"card2.jpg"];
    
    CGFloat y = CGRectGetMaxY(_tableView.frame);
    
    UIButton *b1 = [UIButton buttonWithFrame:CGRectMake(10, y, 140, 35) title:@"查看快券" bgImageName:nil target:self action:@selector(buttonClicked:)];
    b1.tag = 1;
    b1.backgroundColor = kColorRed;
    b1.titleLabel.font = [UIFont fontWithName:kFontBoldName size:14];
    b1.layer.cornerRadius = 3;
    
    UIButton *b2 = [UIButton buttonWithFrame:CGRectMake(170, y, 140, 35) title:@"随便逛逛" bgImageName:nil target:self action:@selector(buttonClicked:)];
    b2.tag = 2;
    b2.backgroundColor = kColorRed;
    b2.titleLabel.font = [UIFont fontWithName:kFontBoldName size:14];
    b2.layer.cornerRadius = 3;
    
    [_scrollView addSubview:b1];
    [_scrollView addSubview:b2];

    [_scrollView addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
    int tag = [sender tag];
    switch (tag) {
        case 1:
            [self toMyCoupons];
            break;
        case 2:
            [self toMain];
            
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else{
        return 2;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1.0f;
    }
    else{
        return 40;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    else{
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 40)];
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _w-20, 40)];
        l.text = @"凭以下银行卡可享受快券优惠";
        l.font = [UIFont fontWithName:kFontName size:12];
        l.textColor = kColorDardGray;
        [v addSubview:l];
        return v;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 55;
    }
    else
        return 82;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int section  = indexPath.section;
    
    
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
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _w, 82)];
        
        imgV.image = [UIImage imageNamed:_imgNames[indexPath.row]];
        [cell addSubview:imgV];
        
    }
    
    return cell;
    
}

#pragma mark - Fcns

- (void)toMyCoupons{
    L();
}
- (void)toMain{
    L();
//    [[KQRootViewController sharedInstance] removeNavVCAboveTab];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
