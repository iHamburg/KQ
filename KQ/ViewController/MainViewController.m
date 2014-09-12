//
//  MainViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MainViewController.h"
#import "Coupon.h"
#import "CouponListCell.h"
#import "CouponDetailsViewController.h"
#import "KQRootViewController.h"
#import "CityViewController.h"
#import "ImageCell.h"
#import "CouponDetailsViewController.h"


#pragma mark - MainViewController

@interface MainViewController (){
    UINavigationController *_couponDetailsNav;

}

@property (nonatomic, strong) Coupon *eventCoupon;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快券";
    self.navigationController.tabBarItem.title = @"首页";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"mainConfig"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
//    NSString *city = _userController.city;
//    if (ISEMPTY(city)) {
//        city = @"选择城市";
//    }
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:city style:UIBarButtonItemStylePlain target:self action:@selector(cityPressed:)];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


}



//#pragma mark - IBAction
//
//- (IBAction)cityPressed:(id)sender{
//    //    L();
//
//    [self performSegueWithIdentifier:@"toCity" sender:nil];
//}

#pragma mark - TableView

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return nil;
//    }
//    else{
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 38)];
//        label.text = @"表格头";
//        return label;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        return 40;
    }
    return 1.0f;
    

}

- (void)initConfigCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if([cell isKindOfClass:[ImageCell class]]){
        
        [cell setValue:[UIImage imageNamed:@"event_banner.jpg"]];
        
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test)]];
        
        
    }

}

- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
          Coupon *project = _models[indexPath.row];
        
         [cell setValue:project];
   
    }
   
}

- (void)test{
    L();
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    L();
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        
        Coupon *coupon = _models[indexPath.row];
        
        [self toCouponDetails:coupon];
        
    }
 

}



#pragma mark - Fcns;



/// 返回基本coupon，在load list的时候再载入购买人数的数据
- (void)loadModels{

    L();

//    [_libraryManager startProgress:nil];
  
    [self.models removeAllObjects];
    
    [_networkClient queryNewestCouponsSkip:0 block:^(NSArray *couponDicts, NSError *error) {
        
//         [_libraryManager dismissProgress:nil];
        
        [self addCouponsInModel:couponDicts];
        
    }];
  
    
}

- (void)refreshModels{
    [_models removeAllObjects];
    
    [self loadModels];
}

- (void)loadMore:(VoidBlock)finishedBlock{
    
    
    int count = [_models count];
    
    [_networkClient queryNewestCouponsSkip:count block:^(NSArray *couponDicts, NSError *error) {
        
        [self addCouponsInModel:couponDicts];
        
        finishedBlock();
    }];
}



- (void)toCouponDetails:(Coupon*)coupon{


    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    
    [_root addNavVCAboveTab:vc];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toCouponDetails"])
    {
        //        L();
        [segue.destinationViewController setValue:sender forKeyPath:@"coupon"];
        
    }
}

- (void)addCouponsInModel:(NSArray *)array {
    for (NSDictionary *dict in array) {
        //            NSLog(@"dict # %@",dict);
        
        Coupon *coupon = [Coupon couponWithDict:dict];
        [self.models addObject:coupon];
        
    }
    
    [self.tableView reloadData];
    
  
//    if (kIsMainApplyEvent) {
//        
//        //FIXME: 这里对于eventCoupon的判定也可以根据id，不一定是第一个coupon
//        self.eventCoupon = [self.models firstObject];
//        
//        [self toEventCoupon:self.eventCoupon];
//        
//    }
    
}


- (void)toEventCoupon:(Coupon*)coupon{
    
    [self performSegueWithIdentifier:@"toCouponDetails" sender:coupon];
}
@end
