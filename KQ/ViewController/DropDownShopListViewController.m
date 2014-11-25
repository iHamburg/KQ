//
//  AroundViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DropDownShopListViewController.h"
#import "ShopDetailsViewController.h"
#import "CouponDetailsViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "ShopListCell.h"


@implementation DropDownShopListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"附近";
    
    self.config = [[TableConfiguration alloc] initWithResource:@"ShopListConfig"];
 
    self.navigationItem.leftBarButtonItem = nil;
    
    self.orders = @[@"离我最近",@"智能排序"];
    NSMutableArray *typeTitles = [NSMutableArray arrayWithCapacity:self.couponTypes.count];
    
    for (CouponType *type in self.couponTypes) {
        [typeTitles addObject:type.title];
    }
    
    
    NSMutableArray *districtTitles = [NSMutableArray arrayWithCapacity:self.districts.count];
    //    [districtTitles addObject:@"全部商区"];
    for (District *obj in self.districts) {
        [districtTitles addObject:obj.title];
    }
    
    
    self.dropDownArray = [NSMutableArray arrayWithArray:@[
                                                          typeTitles,
                                                          districtTitles,
                                                          self.orders
                                                          ]];
    
    
    _dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, 320, 40) dataSource:self delegate:self];
    
    
    //???一定要是root的view吗？
    _dropDownView.mSuperView = [[KQRootViewController sharedInstance]view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_dropDownView reloadData];
}

#pragma mark - TableView
- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"config cell # %@",[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row ]);
    
    if (ISEMPTY(_models)) {
        return;
    }
  
    if ([cell isKindOfClass:[ShopListCell class]]) {
        
        Shop *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self toShopDetails:_models[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns

- (void)loadModels{
    
    
    [self.models removeAllObjects];
    
    [self.searchParams removeAllObjects];
    
    
    
    if (self.couponTypeIndex>0) {
      
        CouponType *obj = self.couponTypes[self.couponTypeIndex];
        
        [self.searchParams setObject:obj.id forKey:@"shopTypeId"];
    }
    
    if (self.districtIndex > 0) {
        District *obj = self.districts[self.districtIndex];
        
        [self.searchParams setObject:obj.id forKey:@"districtId"];
    }
    
    if (self.orderIndex == 0) {
        [self.searchParams setObject:@"distance" forKey:@"order"];
    }
    else{
        [self.searchParams setObject:@"random" forKey:@"order"];
    }
//    NSLog(@"order index # %d" ,self.orderIndex);
    
//    [self addCurrentLocationToSearchParams:self.searchParams];
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
    
    NSLog(@"param # %@", self.searchParams);
    
    
    
    [self willConnect:self.view];
    
    [_networkClient searchShopBranches:self.searchParams block:^(NSDictionary *dict, NSError *error) {
     
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        
        if (!error) {
            NSArray *array = dict[@"shopbranches"];
            
//            NSLog(@"around # %@",array);
            for (NSDictionary *dict in array) {
                Shop *shop = [[Shop alloc] initWithListDict:dict];
                [self.models addObject:shop];
            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }
    }];
}


- (void)loadMore:(VoidBlock)finishedBlock{
    
    int skip = [_models count];
    
    /// param没有改变，只是增加了skip
    [self.searchParams setValue:[NSString stringWithInt:skip] forKey:@"skip"];
    
    
    [_networkClient searchShopBranches:self.searchParams block:^(NSDictionary *dict, NSError *error) {
        finishedBlock();
        
        if (!error) {
            NSArray *array = dict[@"shopbranches"];
            
            //            NSLog(@"around # %@",array);
            for (NSDictionary *dict in array) {
                Shop *shop = [[Shop alloc] initWithListDict:dict];
                [self.models addObject:shop];
            }
            
            [self.tableView reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }

    }];
    
}


- (void)toShopDetails:(Shop*)shop{
    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.shop = shop;
//    [self.navigationController pushViewController:vc animated:YES];
    
    [_root addNavVCAboveTab:vc];
    
}
@end
