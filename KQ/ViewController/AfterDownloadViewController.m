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
#import "ShopBranchListViewController.h"

#define headerHeight 100

@interface AfterDownloadViewController ()

@end

@implementation AfterDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"放入我的快券";
    self.title = @"下载成功";
    
    _config = [[TableConfiguration alloc] initWithResource:@"UserCardsConfig"];
    
    self.isLoadMore = NO;
    
    self.refreshControl = nil;

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
    if (ISEMPTY(_models)) {
        return headerHeight;
    }
    else{
        return 260;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v;
    if (ISEMPTY(_models)) {
        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, headerHeight)];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(55, 11, 32, 32)];
        imgV.image = [UIImage imageNamed:@"icon-tip.png"];
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _w, 55)];
        
        
        l.text = @"已成功放入\"我的快券\"";
        l.textColor = kColorYellow;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = bFont(15);
        l.backgroundColor = [UIColor whiteColor];
        
//        UILabel *l2 = [UILabel alloc]
        
        
        [v addSubview:l];
        [v addSubview:imgV];

    }
    else{
        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 260)];
        
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 170)];
        bgV.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        imgV.image = [UIImage imageNamed:@"icon-tip.png"];
        imgV.center = CGPointMake(_w/2, 65);
        
        UILabel *couponTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+10, _w, 30)];
        couponTitleL.text = _coupon.displayedTitle;
        couponTitleL.textAlignment = NSTextAlignmentCenter;
        couponTitleL.font = bFont(15);
        couponTitleL.textColor = kColorGray;
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(couponTitleL.frame), _w, 20)];
        
        
        l.text = @"刷银行卡即可享用";
        l.textColor = kColorYellow;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = bFont(15);
        l.backgroundColor = [UIColor whiteColor];
        
        
        [v addSubview:bgV];
        [v addSubview:l];
        [v addSubview:imgV];
        [v addSubview:couponTitleL];
        
        float y = 200;
        UIButton *userCouponBtn = [UIButton buttonWithFrame:CGRectMake(10, y, 140, 34) title:@"如何使用" bgImageName:nil target:self action:@selector(showDownloadGuide)];
        userCouponBtn.backgroundColor = kColorRed;
        userCouponBtn.layer.cornerRadius = 3;
        userCouponBtn.titleLabel.font = bFont(15);
        
        UIButton *mainBtn = [UIButton buttonWithFrame:CGRectMake(170, y, 140, 34) title:@"继续下载" bgImageName:nil target:self action:@selector(toCouponList)];
        mainBtn.backgroundColor = [UIColor whiteColor];
//        mainBtn.titleLabel.textColor = kColorRed;
        [mainBtn setTitleColor:kColorRed forState:UIControlStateNormal];
        mainBtn.layer.cornerRadius = 3;
        mainBtn.titleLabel.font = bFont(15);
        mainBtn.layer.borderColor = kColorLightGray.CGColor;
        mainBtn.layer.borderWidth =1;
        
        [v addSubview:userCouponBtn];
        [v addSubview:mainBtn];

        
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
//    else{
//        UIButton *userCouponBtn = [UIButton buttonWithFrame:CGRectMake(10, 40, 140, 34) title:@"如何使用" bgImageName:nil target:self action:@selector(showDownloadGuide)];
//        userCouponBtn.backgroundColor = kColorRed;
//        userCouponBtn.layer.cornerRadius = 3;
//        userCouponBtn.titleLabel.font = bFont(15);
//        
//        UIButton *mainBtn = [UIButton buttonWithFrame:CGRectMake(170, 40, 140, 34) title:@"继续下载" bgImageName:nil target:self action:@selector(toCouponList)];
//        mainBtn.backgroundColor = kColorRed;
//        mainBtn.layer.cornerRadius = 3;
//        mainBtn.titleLabel.font = bFont(15);
//        
//        [v addSubview:userCouponBtn];
//        [v addSubview:mainBtn];
//    }
    
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
        
        
        [self willDisconnectInView:self.view];
        [self.refreshControl endRefreshing];
        
        if (!error) {
            NSArray *array = dict[@"cards"];
            
//            NSLog(@"cards # %@",array);
            
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

// 成功加载之后就更换页面
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

- (void)showDownloadGuide{
    
   
    if (!_downloadGuideV) {
        _downloadGuideV = [[DownloadGuideView alloc] initWithFrame:self.view.window.bounds];
        _downloadGuideV.imgNames = @[@"guide02-step03.jpg",@"guide02-step04.jpg"];
       
        
    }
     __weak AfterDownloadViewController *vc = self;
    _downloadGuideV.pageClickedBlock = ^(int index){ // banner的新手教程要进入couponlist！
        L();


        [vc.navigationController popViewControllerAnimated:YES];

        [vc pushShopbranchList];
        
        // 延迟退出，避免看到 couponDetails
        [vc.downloadGuideV performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    };

    _downloadGuideV.backBlock = ^{
        
        [vc.downloadGuideV removeFromSuperview];
        [vc.navigationController popViewControllerAnimated:YES];
    
    };
    
    [_downloadGuideV reset];
    [self.navigationController.view addSubview:_downloadGuideV];
    
//    [self.navigationController popViewControllerAnimated:NO];
}
- (void)pushShopbranchList{
    ShopBranchListViewController *vc = [[ShopBranchListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.headerShopId = _coupon.shopId;
    
    //需要把 root 之前的 nav 给删除
//    UIViewController *nav = _root.nav;
//  
//    [_root addNavVCAboveTab:vc];
//    
//    [nav.view removeFromSuperview];

//    [self.navigationController popViewControllerAnimated:NO];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)toCouponList{
    //需要把 root 之前的 nav 给删除
    UIViewController *nav = _root.nav;
    [_root addNavCouponList];
    
    [nav.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];

}

@end
