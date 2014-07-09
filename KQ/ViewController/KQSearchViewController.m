//
//  KQSearchViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-27.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQSearchViewController.h"


@interface KQSearchViewController ()

@end

@implementation KQSearchViewController

- (void)setSearchType:(int)searchType{
    _searchType = searchType;
    
    if (_searchType == 0) {
        [self searchDistrict];
    }
    else if(_searchType == 1){
        [self searchCouponType];
    }
}


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
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:kColorYellow];
  
    

//    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-50, 40)];
//    
//    theSearchBar.placeholder = @"enter province name";
//    
//    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//    
//    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
//    
//    theSearchBar.delegate = self;
//    
//    _searchBar = theSearchBar;
    
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"按地区找",@"按分类找"]];
    
    seg.frame = CGRectMake(0, 0, 160, 30);
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
   
    
    
    NSArray *leftKeys = _manager.districts;
    NSMutableDictionary *dataSource = [NSMutableDictionary dictionary];
    for (District *district in leftKeys) {
        
        [dataSource setObject:district.subDistricts  forKey:district];
    }

    _districtDataSource = [dataSource copy];
    
    NSArray *rightKeys = _manager.couponTypes;
    [dataSource removeAllObjects];
    for (CouponType *type in rightKeys) {
//        NSArray *arr = @[type.title,type.title,type.title];
        [dataSource setObject:type.subTypes forKey:type];
    }
    _couponTypeDataSource = [dataSource copy];
    
    
    
    //
    _districtHotKeywords = @[@"徐汇区",@"静安区",@"浦东新区"];
 
    _couponTypeHotKeywords = @[@"咖啡厅",@"休闲娱乐",@"运动健身"];
    
    __weak KQSearchViewController *vc = self;
    [self.tableView setSelectedBlock:^(id object) {
        
        
        NSLog(@"select # %@",object);
        
        [vc toCouponList];
    }];
    
//    [self searchDistrict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

     [self searchDistrict];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ///动态调整table的高度
    CGFloat hTable = 233;
    if (isPhone5) {
        hTable = 321;
    }
    
    [self.tableView setSize:CGSizeMake(320, hTable)];
//    NSLog(@"self # %@, table # %@",self.view, _tableView);
    

}

#pragma mark - SearchBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    L();
    [self toCouponList];
}

#pragma mark - IBAction

- (IBAction)segmentChanged:(UISegmentedControl*)sender{
    self.searchType = sender.selectedSegmentIndex;
}



#pragma mark - Fcns
- (void)searchDistrict{
    L();
    
    _hotSearchView.titles = _districtHotKeywords;
    
    _tableView.dataSource = _districtDataSource;
    
    __weak KQSearchViewController *vc = self;
    [_hotSearchView setSelectBlock:^(int tag) {
//        L();
        
        
        [vc toCouponList];
    }];
    
}
- (void)searchCouponType{
    L();
    _hotSearchView.titles = _couponTypeHotKeywords;
    
    _tableView.dataSource = _couponTypeDataSource;
    
    __weak KQSearchViewController *vc = self;
    [_hotSearchView setSelectBlock:^(int tag) {
        L();
        [vc toCouponList];
    }];

}


- (void)didSelectedDistrict:(District*)district{
    
}

- (void)didSelectedCouponType:(CouponType*)couponType{
    
}

- (void)toCouponList{

    [self performSegueWithIdentifier:@"toSearchResults" sender:nil];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
