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
#import "AddCardViewController.h"

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
    //
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"未使用",@"已使用",@"已过期"]];
    seg.selectedSegmentIndex = 0;
    seg.frame = CGRectMake(0, 0, 260, 30);
    seg.center = _tableHeader.center;
    [seg addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    [_tableHeader addSubview:seg];

    
 
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponMyListConfig"];
    self.isLoadMore = NO;
    
    _alert = [[UIAlertView alloc] initWithTitle:@"" message:@"添加银行卡即可享用快券" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即添加", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    int num = _userController.people.cardNum;

    if (num == 0) {
        [_alert show];
    }
    
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _tableHeader.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return _tableHeader;
    
}


- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if (ISEMPTY(_models)) {
        return;
    }
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        [cell setText:[NSString stringWithFormat:@"%@张",project.number]];
        
    }
 
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(ISEMPTY(self.models)){
        return;
    }
    
    
    Coupon *coupon = self.models[indexPath.row];
    
    if (coupon.active) {
        [self pushCouponDetails:coupon];
        
    }
    else{
        
        [_libraryManager startHint:@"该快券已失效"];
    }

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SegmentedControl
- (IBAction)segmentedControlChanged:(UISegmentedControl*)sender{
    int index = (int)sender.selectedSegmentIndex;
//    NSLog(@"index # %d",index);
    self.couponStatus = index;

    //重新刷新
    [self loadModels];

}


#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //    L();
    
    if (buttonIndex == 1) {
        [self pushAddCard];
    }
}

#pragma mark - Fcns;


- (void)loadModels{
    
    
    [self.models removeAllObjects];


    [self willConnect:self.view];
    
    
    if (_couponStatus == CouponStatusUnused) {
        _mode = @"unused";
    }
    else if(_couponStatus == CouponStatusUsed){
        _mode = @"used";
    }
    else if(_couponStatus == CouponStatusExpired){
        _mode = @"expired";
    }
    
    [_networkClient queryDownloadedCoupon:_userController.uid mode:_mode skip:0 block:^(NSDictionary *dict, NSError *error) {

        [self willDisconnectInView:self.view];
        [self.refreshControl endRefreshing];
        

        if (!error) {
            
//            NSLog(@"user coupons # %@",dict);
            
            NSArray *array = dict[@"coupons"];
            
            
//             NSLog(@"array # %@",array);
            
            if (ISEMPTY(array)) {
                NSString *msg;
                if (_couponStatus == CouponStatusUnused) {
                    msg = @"没有未使用的快券";
                }
                else if(_couponStatus == CouponStatusUsed){
                    msg = @"没有已经使用的快券";
                }
                else if(_couponStatus == CouponStatusExpired){
                    msg = @"没有过期的快券";
                }

                [_libraryManager startHint:msg duration:1];
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

- (void)loadMore:(VoidBlock)finishedBlock{
    
    int count = [_models count];
    
    _networkFlag = YES;
    
    [_networkClient queryDownloadedCoupon:_userController.uid mode:_mode skip:count block:^(NSDictionary *dict, NSError *error) {
        
        if (!error) {
            
            //            NSLog(@"user coupons # %@",dict);
            
            NSArray *array = dict[@"coupons"];
            
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



- (void)pushCouponDetails:(Coupon*)coupon{
    
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];

    

}

- (void)pushAddCard{
    AddCardViewController *vc = [[AddCardViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
     [self.navigationController pushViewController:vc animated:YES];
}
@end
