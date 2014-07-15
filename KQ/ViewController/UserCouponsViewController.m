//
//  UserCouponsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserCouponsViewController.h"
#import "CouponListCell.h"


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

//    L();

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
    int index = sender.selectedSegmentIndex;
    NSLog(@"index # %d",index);
    if (index == 1 ||index == 2) {
        [self demoEmptyTable];
    }
    else{
        [self loadModels];
    }
}

#pragma mark - Fcns;

- (void)queryCoupons:(CouponStatus)status{


    
}

- (void)demoEmptyTable{
    [self.models removeAllObjects];
    [self.tableView reloadData];

    [_libraryManager startHint:@"没有优惠券" duration:1];
    

    
}

- (void)loadModels{
    
    
    if (!ISEMPTY(_models)) {
        return;
    }
    
    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];


    [_networkClient queryDownloadedCoupon:_userController.uid block:^(NSArray *couponDicts, NSError *error) {
        [_libraryManager dismissProgress:nil];  

        if (!ISEMPTY(couponDicts)) {
            
            for (NSDictionary *dict in couponDicts) {
                if ([dict isKindOfClass:[NSNull class]]) {
                    continue;
                }
                
                Coupon *coupon = [Coupon couponWithDict:dict];
                [_models addObject:coupon];
                NSLog(@"coupon # %@",coupon.id);
                
            }
        }
        else{
             [_libraryManager startHint:@"还没有优惠券" duration:1];
        }

        [self.tableView reloadData];

    }];
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}


- (void)toCouponDetails:(Coupon*)coupon{
    
    
    
    [self performSegueWithIdentifier:@"toCouponDetails" sender:coupon];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toCouponDetails"])
    {
        //        L();
        [segue.destinationViewController setValue:sender forKeyPath:@"coupon"];
        
    }
}



@end
