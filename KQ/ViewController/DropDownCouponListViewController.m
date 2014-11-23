//
//  SearchResultsViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DropDownCouponListViewController.h"
#import "CouponSearchListCell.h"
#import "CouponDetailsViewController.h"

@interface DropDownCouponListViewController ()

@end

@implementation DropDownCouponListViewController

- (void)setKeyword:(NSString *)keyword{
    _keyword = keyword;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    
       
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponSearchListConfig"];
    
    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-50, 40)];
    
    theSearchBar.placeholder = @"输入搜索内容";
    
    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    theSearchBar.delegate = self;
    
     self.tableView.tableHeaderView = theSearchBar;
    
    _searchBar = theSearchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SearchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    L();
    _keyword = searchBar.text;
    
    [self loadModels];
   
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}

//cancel按钮点击时调用

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar

{
    
    L();
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
}


#pragma mark - TableView
- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"config cell # %@",[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row ]);
    
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        [cell setValue: _models[indexPath.row]];
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self pushCouponDetails:_models[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns

- (void)loadModels{
    
    
    [self.models removeAllObjects];
    
    [self.searchParams removeAllObjects];
    
    if (self.couponTypeIndex>0) {
        CouponType *obj = self.couponTypes[self.couponTypeIndex-1];
        
        [self.searchParams setObject:obj.id forKey:@"couponTypeId"];
    }
    
    if (self.districtIndex > 0) {
        District *obj = self.districts[self.districtIndex-1];
        
        [self.searchParams setObject:obj.id forKey:@"districtId"];
    }
    
    [_searchParams setObject:_keyword forKey:@"keyword"];
    
    //    [self addCurrentLocationToSearchParams:self.searchParams];
    
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
    
    NSLog(@"param # %@", self.searchParams);
    
    
    
    [self willConnect:self.view];
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
        [self willDisconnect];
        [self.refreshControl endRefreshing];
        
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
     
//            NSLog(@"searchcoupons # %@",array);
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithSearchDict:dict];
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
    
    int skip = [_models count];
    
    /// param没有改变，只是增加了skip
    [self.searchParams setValue:[NSString stringWithInt:skip] forKey:@"skip"];
    
    
    [_networkClient searchShopBranches:self.searchParams block:^(NSDictionary *dict, NSError *error) {
        finishedBlock();
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
            
            //            NSLog(@"around # %@",array);
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithSearchDict:dict];
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

@end
