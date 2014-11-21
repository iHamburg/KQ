//
//  UserCouponsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCouponsViewController.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"

#pragma mark - UserCouponsVC

@interface UserCouponsViewController (){
    UIView *_tableHeader;
}



@end

@implementation UserCouponsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的快券";


    _tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _tableHeader.backgroundColor = kColorBG;
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"未使用",@"已使用",@"已过期"]];
    seg.selectedSegmentIndex = 0;
    seg.frame = CGRectMake(0, 0, 260, 30);
    seg.center = _tableHeader.center;
    [seg addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    [_tableHeader addSubview:seg];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    self.config = [[TableConfiguration alloc] initWithResource:@"UserCouponsConfig"];
    self.isLoadMore = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _tableHeader.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return _tableHeader;
    
}


- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
 
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = self.models[indexPath.row];
    
    [self toCouponDetails:obj];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SegmentedControl
- (IBAction)segmentedControlChanged:(UISegmentedControl*)sender{
    int index = (int)sender.selectedSegmentIndex;
    NSLog(@"index # %d",index);

    [self queryCoupons:index];
}

#pragma mark - Fcns;

- (void)queryCoupons:(CouponStatus)status{

    switch (status) {
        case CouponStatusUnused:
            [self loadModels];
            break;
        case CouponStatusUsed:
        case CouponStatusExpired:
            
            //应该显示不同的优惠券
            [self demoEmptyTable];
        default:
            break;
    }
    
}

- (void)demoEmptyTable{
    [self.models removeAllObjects];
    [self.tableView reloadData];

    [_libraryManager startHint:@"没有优惠券" duration:1];
    
    
}

- (void)loadModels{
    
    
    [self.models removeAllObjects];


    [self willConnect:self.view];
    
    [_networkClient queryDownloadedCoupon:_userController.uid skip:0 block:^(NSDictionary *dict, NSError *error) {


        [self willDisconnect];
        [self.refreshControl endRefreshing];
        

        if (!error) {
            NSArray *array = dict[@"coupons"];
            
             NSLog(@"array # %@",array);
            
            if (ISEMPTY(array)) {
                [_libraryManager startHint:@"还没有下载优惠券" duration:1];
            }
            

//            NSLog(@"dCoupons # %@",array);
            for (NSDictionary *dict in array) {
                
                Coupon *coupon = [[Coupon alloc] initWithDownloadedDict:dict];
                
                [self.models addObject:coupon];
            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }


    }];
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}


- (void)toCouponDetails:(Coupon*)coupon{
    

    [_root toCouponDetails:coupon];

}


@end
