//
//  KQSearchViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-27.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQSearchViewController.h"
#import "Coupon.h"


@interface KQSearchViewController ()

- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params;
- (void)toCouponList;

@end

@implementation KQSearchViewController
//
//- (void)setSearchType:(SearchType)searchType{
//    _searchType = searchType;
//    
//    if (_searchType == SearchDistrict) {
//
//        _hotSearchView.titles = _districtHotKeywords;
//        _tableView.dataSource = _districtDataSource;
//        self.searchBar.placeholder = @"输入地区的名字查询";
//        
//        __weak KQSearchViewController *vc = self;
//        [_hotSearchView setSelectBlock:^(int tag) {
//            //        L();
//            NSString *title = vc.districtHotKeywords[tag];
//            District *district = [vc.manager districtWithTitle:title];
//            
//            [vc.searchParams removeAllObjects];
//            [vc.searchParams setObject:district.id forKey:@"districtId"];
//            [vc addCurrentLocationToSearchParams:vc.searchParams];
//            
//            [vc startSearch];
//        }];
//
//    }
//    else if(_searchType == SearchCouponType){
//
//        _hotSearchView.titles = _couponTypeHotKeywords;
//        _tableView.dataSource = _couponTypeDataSource;
//        self.searchBar.placeholder = @"输入分类的名字查询";
//
//        
//        __weak KQSearchViewController *vc = self;
//        [_hotSearchView setSelectBlock:^(int tag) {
//            L();
//            NSString *title = vc.couponTypeHotKeywords[tag];
//            CouponType *couponType = [vc.manager couponTypeWithTitle:title];
//            [vc.searchParams removeAllObjects];
//            [vc.searchParams setObject:couponType.id forKey:@"couponTypeId"];
//            [vc addCurrentLocationToSearchParams:vc.searchParams];
//            
//            [vc startSearch];
//        }];
//
//    }
//}
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    
    _root = [KQRootViewController sharedInstance];
    _userController = [UserController sharedInstance];
    _networkClient = [NetworkClient sharedInstance];
    _libraryManager = [LibraryManager sharedInstance];
    _manager = [CouponManager sharedInstance];
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = kColorBG;
    
//    self.navigationController.navigationBar.translucent = NO;
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTintColor:kColorYellow];
  
    
//    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"按地区找",@"按分类找"]];
//    
//    seg.frame = CGRectMake(0, 0, 160, 30);
//    seg.selectedSegmentIndex = 0;
//    [seg addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = seg;
   
    
    self.searchParams = [NSMutableDictionary dictionary];
    
    
    /// HotSearchView
    _districtHotKeywords = @[@"徐汇区",@"静安区",@"浦东新区"];
    _couponTypeHotKeywords = @[@"美食",@"休闲娱乐",@"购物"];
    
    ///init tableview

//    NSArray *leftKeys = _manager.districts;
//    NSMutableDictionary *dataSource = [NSMutableDictionary dictionary];
  
//    for (District *district in leftKeys) {
    
        //TODO:  district 换成2行而不是3行的
//        [dataSource setObject:district.subDistricts  forKey:district];
//    }
    
//    _districtDataSource = [dataSource copy];
    
    NSArray *rightKeys = _manager.couponTypes;
//    [dataSource removeAllObjects];
//    for (CouponType *type in rightKeys) {
          //TODO:  CouponType 换成2行而不是3行的
//        NSArray *arr = @[type.title,type.title,type.title];
//        [dataSource setObject:type.subTypes forKey:type];
//    }
//    _couponTypeDataSource = [dataSource copy];
    
//    __weak KQSearchViewController *vc = self;
   
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];


    //重新刷一下界面
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    NSLog(@"self # %@, table # %@",self.view, _tableView);

}

#pragma mark - SearchBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    L();
    
    [searchBar resignFirstResponder];
    
    NSLog(@"search # %@",searchBar.text);
    NSString *keyword = searchBar.text;
    
    KQSearchViewController *vc = self;
    
    [vc.searchParams removeAllObjects];
    
    
    
    [vc addCurrentLocationToSearchParams:vc.searchParams];
    
    
    [vc startSearch];

    
}

#pragma mark - IBAction



#pragma mark - Fcns
- (void)startSearch{
    
    
    NSLog(@"start Search # %@",self.searchParams);
    
    [_libraryManager startProgress:nil];
    [_networkClient searchCoupons:self.searchParams block:^(NSArray *array, NSError *error) {
        [_libraryManager dismissProgress:nil];

        if (ISEMPTY(array)) {
            
            [_libraryManager startHint:@"暂时还没有结果" duration:1];
        }else{
        

            self.searchResults = [NSMutableArray array];
            
            for (NSDictionary *dict in array) {
                if (!ISEMPTY(dict)) {
                    BOOL flag = YES;
                    ///如果dict的objectId在results的id
                    for (Coupon *coupon in self.searchResults) {
                        if ([coupon.id isEqualToString:dict[@"objectId"]]) {
                            flag = NO;
                            break;
                        }
                    }
                    
                    if (flag == NO) {
                        continue;
                    }
                    
                    Coupon *coupon = [Coupon couponWithDict:dict];
                    coupon.nearestDistance = [_userController distanceFromLocation:coupon.nearestLocation];

                    [self.searchResults addObject:coupon];
                }
            }

         
            [self toCouponList];
        }
        
    }];
}

- (void)toCouponList{

    [self performSegueWithIdentifier:@"toSearchResults" sender:self.searchResults];
}



- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params{

    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [params setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [params setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
}

@end
