//
//  AfterDownload2ViewController.m
//  KQ
//
//  Created by Forest on 14-11-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AfterDownloadViewController.h"
#import "CardCell.h"
#import "AddCardViewController.h"
#import "UserCouponsViewController.h"


#define headerHeight 100

@interface AfterDownloadViewController ()

@end

@implementation AfterDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"放入我的快券";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCardsConfig"];
    
    self.isLoadMore = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    L();
    
}

#pragma mark - TableView



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(55, 11, 32, 32)];
    imgV.image = [UIImage imageNamed:@"icon-tip.png"];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _w, 55)];
    
    
    l.text = @"已成功放入\"我的快券\"";
    l.textColor = kColorYellow;
    l.textAlignment = NSTextAlignmentCenter;
    l.font = bFont(15);
    l.backgroundColor = [UIColor whiteColor];
    
    

    
    [v addSubview:l];
    [v addSubview:imgV];
    
    ///如果用户有卡,显示
    if (!ISEMPTY(_models)) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, _w, 40)];
        label.text = @"凭以下银行卡可享受快券优惠";
        label.textColor = kColorGray;
        label.font = [UIFont fontWithName:kFontBoldName size:15];
        [v addSubview:label];
    }
  
        
    return v;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 200;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 200)];
    
    if (ISEMPTY(_models)) {
        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(10, 43, _w-20, 34) title:@"+ 添加银行卡" bgImageName:nil target:self action:@selector(addButtonClicked:)];
        btn.backgroundColor = kColorGreen;
        btn.layer.cornerRadius = 3;
        btn.titleLabel.font = bFont(15);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btn.frame)+10, _w, 30)];
        label.text = @"中国银联将保障您的账户信息安全";
        label.textColor = kColorGray;
        label.font = [UIFont fontWithName:kFontBoldName size:12];
        label.textAlignment = NSTextAlignmentCenter;
        [v addSubview:btn];
        [v addSubview:label];

    }
    else{
        UIButton *userCouponBtn = [UIButton buttonWithFrame:CGRectMake(10, 40, 140, 34) title:@"查看快券" bgImageName:nil target:self action:@selector(pushUserCoupons)];
        userCouponBtn.backgroundColor = kColorRed;
        userCouponBtn.layer.cornerRadius = 3;
        userCouponBtn.titleLabel.font = bFont(15);
        
        UIButton *mainBtn = [UIButton buttonWithFrame:CGRectMake(170, 40, 140, 34) title:@"继续逛逛" bgImageName:nil target:self action:@selector(toMain)];
        mainBtn.backgroundColor = kColorRed;
        mainBtn.layer.cornerRadius = 3;
        mainBtn.titleLabel.font = bFont(15);
        
        [v addSubview:userCouponBtn];
        [v addSubview:mainBtn];
    }
    
//    v.backgroundColor = kColorGreen;
//    NSLog(@"foot # %@",v);
    return v;
    
}




- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"cell # %@",cell);
    if ([cell isKindOfClass:[CardCell class]]) {
        cell.value = _models[indexPath.row];
    }
    
}



#pragma mark - Fcns


- (void)loadModels{
    
    L();
    
    
    [self.models removeAllObjects];
    [self willConnect:self.view];
    
    
    [_networkClient queryCards:_userController.uid block:^(NSDictionary *dict, NSError *error) {
        
        
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        if (!error) {
            NSArray *array = dict[@"cards"];
            
            NSLog(@"cards # %@",array);
            
            for (NSDictionary *dict in array) {
                
                Card *card = [[Card alloc] initWithDict:dict];
                [self.models addObject:card];
            }
            
            [self.tableView reloadData];
        }
        else {
            [ErrorManager alertError:error];
        }
        
        
    }];
}

#pragma mark - IBAction

- (IBAction)addButtonClicked:(id)sender{
    [self presentAddCard];
}

#pragma mark - Fcn
- (void)presentAddCard{
    L();
    AddCardViewController *vc = [[AddCardViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.presentBlock = ^(BOOL successed, NSError *error){
        if (successed) {
            //成功绑卡
            
            [self.tableView reloadData];
        }
    };
    
    [_root presentNav:vc];
    
}

- (void)pushUserCoupons{
    
    
    UserCouponsViewController *vc = [[UserCouponsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)toMain{
    [_root removeNavVCAboveTab];
}

@end
