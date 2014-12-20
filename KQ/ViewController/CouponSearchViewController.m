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
#import "DropDownCouponListViewController.h"
#import "UIImageView+Webcache.h"

@interface CouponSearchViewController ()

@end

@implementation CouponSearchViewController


- (void)setIsLoadMore:(BOOL)isLoadMore{
    
    _isLoadMore = isLoadMore;
    if (isLoadMore == NO) {
        [_loadMoreFooterView removeFromSuperview];
    }
    else{
        
    
        [_rightV addSubview:_loadMoreFooterView];
    }
    
//    NSLog(@"loadFoot # %@",_loadMoreFooterView);
}
- (void)setSelectedIndex:(int)selectedIndex{
    
    _selectedIndex = selectedIndex;
    
    _couponType = _searchTypes[selectedIndex];
    
    
    [_leftV reloadData];
 
    [_models removeAllObjects];
    [_rightV reloadData];
    
    [self loadModels];
    
}

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
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.searchTypes = _manager.searchCouponTypes;
    
    self.searchParams = [NSMutableDictionary dictionary];
    
    _couponType = _searchTypes[0]; //默认全部类型
    
    _keyword = @"";
    
    
    
    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    
    theSearchBar.placeholder = @"输入搜索内容";
    
    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    theSearchBar.delegate = self;
    
    _searchBar = theSearchBar;

    
    
    _leftV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 70, self.view.height - 44) style:UITableViewStyleGrouped];
    _leftV.delegate = self;
    _leftV.dataSource = self;
    _leftV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftV.scrollEnabled = NO;
    
    _leftImgNames = @[@"main_search_all.png",@"main_search_eating.png",@"main_search_beauty.png"];

//    NSString *
    
    _rightV = [[UITableView alloc] initWithFrame:CGRectMake(70, 40, 250, self.view.height - 44) style:UITableViewStyleGrouped];
    _rightV.delegate = self;
    _rightV.dataSource = self;
    _rightV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _rightV.autoresizingMask = kAutoResize;
    _rightV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    if (_loadMoreFooterView == nil) {
        
        LoadMoreTableFooterView *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(70.0f, _rightV.contentSize.height - 30, _rightV.frame.size.width, 30)];
        view.delegate = self;

        _loadMoreFooterView = view;

        
        
    }
    self.isLoadMore = YES;
    
    
    self.view.backgroundColor = kColorBG;
    
    [self.view addSubview:_searchBar];
    [self.view addSubview:_leftV];
    [self.view addSubview:_rightV];
    
    [self loadModels];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self loadModels];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
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
    
    [self toSearchResult:_keyword];
    
    searchBar.showsCancelButton = NO;
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
    if (tableView == _leftV) {
        return 20;

    }
    else
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
        
        //70x96
        
        CouponType *type = self.searchTypes[row];
                
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(19, 10, 32, 32)];
        
//        if (!ISEMPTY(type.imgUrl)) {
//            [imgV setImageWithURL:[NSURL URLWithString:type.imgUrl]];
//        }
//        else{
//            imgV.image = [UIImage imageNamed:_leftImgNames[row]];
//        }

        if (row<_leftImgNames.count) {
            imgV.image = [UIImage imageNamed:_leftImgNames[row]];

        }
        
        KQLabel *label = [[KQLabel alloc]initWithFrame:CGRectMake(10, 52, 50, 30)];
        label.text = type.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = bFont(12);
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, cell.height)];
        v.backgroundColor = kColorYellow;
        v.tag = 1;
        
        [cell addSubview:imgV];
        [cell addSubview:label];
//        [cell addSubview:v];
        
        if (row == _selectedIndex) {
            [cell setBackgroundColor:[UIColor whiteColor]];
            UIView *v = [cell viewWithTag:1];
            v.alpha = 1.0;
        }
        else{
            [cell setBackgroundColor:[UIColor clearColor]];
            UIView *v = [cell viewWithTag:1];
            v.alpha = 0.0;

        }
        
        
    }
    else{
        NSString *identifier =@"right";
        
        [tableView registerClass:[CouponSearchShortListCell class] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        cell.value = _models[row];
        
        [cell addBottomLine:kColorLightGray];

    }
   
  
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftV) {
      
        self.selectedIndex = indexPath.row;
  
    }
    else{
        
        [_searchBar resignFirstResponder];
        [self toCouponDetails:_models[indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}





#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    
    [_loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:_rightV];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    NSLog(@"didi scroll # %@",_loadMoreFooterView);
    
    [_loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //        NSLog(@"did end trigger");
    
    [_loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark LoadMoreTableFooterDelegate Methods

- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view {
    
    //    NSLog(@"Did Trigger");
    
    [self reloadTableViewDataSource];
    
    [self loadMore:^{
        [self doneLoadingTableViewData];
    } ];
}

- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view {
    return _reloading;
}


#pragma mark - Fcns

- (void)loadModels{
    
    
    [self.models removeAllObjects];
    
    [self.searchParams removeAllObjects];
    
    ///很奇怪，不能把shopTypeId设为0？
    if ([_couponType.id intValue] != 0) {
           [self.searchParams setObject:_couponType.id forKey:@"shopTypeId"];
    }
    


    
    //    [self addCurrentLocationToSearchParams:self.searchParams];
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [_searchParams setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
    
    [_searchParams setObject:@"distance" forKey:@"order"];
    
    NSLog(@"param # %@", self.searchParams);
    
    
//   [_libraryManager startLoadingInView:self.view];
    
    [_libraryManager startProgress];
    
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
//      [_libraryManager stopLoading];
        
        [_libraryManager dismissProgress];
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
            
//            NSLog(@"searchcoupons # %@",array);

            
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
    
    NSLog(@"params # %@",self.searchParams);
    
    [_networkClient searchCoupons:self.searchParams block:^(NSDictionary *dict, NSError *error) {
       
        
        
        finishedBlock();
        
        if (!error) {
            NSArray *array = dict[@"coupons"];
            
            //            NSLog(@"around # %@",array);
         
            for (NSDictionary *dict in array) {
            
//                NSLog(@"dict # %@",dict);
                
                Coupon *coupon = [[Coupon alloc] initWithSearchDict:dict];
                
                [coupon display];
                
                [self.models addObject:coupon];
            
            }
            
            [_rightV reloadData];
            // 跳到头部
//            [_rightV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

        }
        else{
            [ErrorManager alertError:error];
        }
        
    }];
    
}

- (void)toCouponDetails:(Coupon*)coupon{
    
    
    [_root toCouponDetails:coupon];
}

- (void)toSearchResult:(NSString*)keyword{
    
    DropDownCouponListViewController *vc = [[DropDownCouponListViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.view.alpha = 1;
    vc.keyword = keyword;
    
    [_root addNavVCAboveTab:vc];
}
@end
