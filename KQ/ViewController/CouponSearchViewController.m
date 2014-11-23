//
//  CouponSearchViewController.m
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponSearchViewController.h"
#import "CouponType.h"
#import "CouponSearchShortListCell.h"

@interface CouponSearchViewController ()

@end

@implementation CouponSearchViewController

- (NSMutableArray*)models{
    if (!_models) {
        _models = [NSMutableArray array];
        
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userController = [UserController sharedInstance];
    _networkClient = [NetworkClient sharedInstance];
    _libraryManager = [LibraryManager sharedInstance];
    _manager = [CouponManager sharedInstance]; //需要调用HUD，必须等root已经有view
    _root = [KQRootViewController sharedInstance];
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"搜索";
    
    self.view.backgroundColor = kColorBG;
    
    self.searchTypes = _manager.searchCouponTypes;
    
    self.searchParams = [NSMutableDictionary dictionary];
    
    _couponType = _searchTypes[0]; //默认全部类型
    
    _keyword = @"";
    
    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
//    theSearchBar.showsCancelButton = YES;
    
    theSearchBar.placeholder = @"输入搜索内容";
    
    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    theSearchBar.delegate = self;
    
    _searchBar = theSearchBar;

    
    _leftV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 70, self.view.height - 50) style:UITableViewStyleGrouped];
    _leftV.delegate = self;
    _leftV.dataSource = self;
    
    
    _rightV = [[UITableView alloc] initWithFrame:CGRectMake(70, 40, 250, self.view.height - 50) style:UITableViewStyleGrouped];
    _rightV.delegate = self;
    _rightV.dataSource = self;
    _rightV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_searchBar];
    [self.view addSubview:_leftV];
    [self.view addSubview:_rightV];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadModels];
}

- (void)didReceiveMemoryWarning {
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
}

//cancel按钮点击时调用

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar

{
    
    L();
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
}


#pragma mark - TableView


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == _leftV) {
        return 3;
    }
    else{
        return _models.count;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 96;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int row = indexPath.row;
    ConfigCell *cell;
    if (tableView == _leftV) {
        NSString *identifier =@"left";
        
        [tableView registerClass:[ConfigCell class] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
//        cell.textLabel.text = @"123";
        
//        NSString *imgName = [_config imageNameForIndexPath:indexPath];
        
        CouponType *type = self.searchTypes[row];
        
        cell.textLabel.text = type.title;
       
    }
    else{
        NSString *identifier =@"right";
        
        
        
        [tableView registerClass:[CouponSearchShortListCell class] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        // 只要有label，就会显示在textLabel上！但如果是textfieldCell，textLabel会被盖到下面去不显示
//        cell.textLabel.text = @"1234";

        cell.value = _models[row];
    }
   
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self toCouponDetails:_models[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns

- (void)loadModels{
    
    
    [self.models removeAllObjects];
    
    [self.searchParams removeAllObjects];
    
    [self.searchParams setObject:_couponType.id forKey:@"couponTypeId"];

    [self.searchParams setObject:_keyword forKey:@"keyword"];
       
    //    [self addCurrentLocationToSearchParams:self.searchParams];
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
    
    NSLog(@"param # %@", self.searchParams);
    
    
   [_libraryManager startLoadingInView:self.view];
    
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
      [_libraryManager stopLoading];
       
//        [self.refreshControl endRefreshing];
        
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
            
            NSLog(@"searchcoupons # %@",array);
            for (NSDictionary *dict in array) {
                Coupon *coupon = [[Coupon alloc] initWithSearchDict:dict];
                [self.models addObject:coupon];
                
            }
            
            [_rightV reloadData];
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
                Coupon *coupon = [[Coupon alloc] initWithSearchDict:dict];
                [self.models addObject:coupon];
            }
            
            [_rightV reloadData];
        }
        else{
            [ErrorManager alertError:error];
        }
        
    }];
    
}

- (void)toCouponDetails:(Coupon*)coupon{
    [_root toCouponDetails:coupon];
}
@end
