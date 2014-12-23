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
    
    
    self.orders = @[@"智能排序",@"离我最近",@"人气最高"];
    
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
    
    _searchBar.text = _keyword;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    [_searchBar resignFirstResponder];
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
    
    
    if (ISEMPTY(_models)) {
        return;
    }

    
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
        CouponType *obj = self.couponTypes[self.couponTypeIndex];
        
        [self.searchParams setObject:obj.id forKey:@"shopTypeId"];
    }
    
    if (self.districtIndex > 0) {
        District *obj = self.districts[self.districtIndex];
        
        [self.searchParams setObject:obj.id forKey:@"districtId"];
    }
    
    if (self.orderIndex == 0) {
        //智能
        [self.searchParams setObject:@"random" forKey:@"order"];
    }
    else if(self.orderIndex == 1){
        //最近
        [self.searchParams setObject:@"distance" forKey:@"order"];
    }
    else if(self.orderIndex == 2){
        //人气
        [self.searchParams setObject:@"hot" forKey:@"order"];
    }
    
    if (!ISEMPTY(_keyword)) {
        [_searchParams setObject:_keyword forKey:@"keyword"];
    }

    
//    [_searchParams setObject:@"西" forKey:@"keyword"];
    
    
    
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
    
    NSLog(@"param # %@", self.searchParams);
    
    
    
    [self willConnect:self.view];
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
        [self willDisconnectInView:self.view];
        [self.refreshControl endRefreshing];
        
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
     
//            NSLog(@"searchcoupons # %@",array);
            
            if (ISEMPTY(array)) {
                [_libraryManager startHint:@"没有找到相关结果"];
            }
            
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
    
    
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
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
