//
//  KQSearchViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-27.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "UserController.h"
#import "KQRootViewController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"
#import "CouponManager.h"
#import "DistrictsTableView.h"
#import "TagsView.h"
#import "District.h"
#import "CouponType.h"


@interface KQSearchViewController : UIViewController<UISearchBarDelegate>{

    KQRootViewController *_root;
    UserController *_userController;
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
    CouponManager *_manager;
    

    NSArray *_districtHotKeywords, *_couponTypeHotKeywords;
    NSDictionary *_districtDataSource, *_couponTypeDataSource;
    
    IBOutlet UISearchBar *_searchBar;
    IBOutlet TagsView *_hotSearchView;
    IBOutlet DistrictsTableView *_tableView;
 
}

@property (nonatomic, assign) int searchType;

@property (nonatomic, strong) DistrictsTableView *tableView;

- (IBAction)segmentChanged:(id)sender;

- (void)searchDistrict;
- (void)searchCouponType;


- (void)didSelectedDistrict:(District*)district;
- (void)didSelectedCouponType:(CouponType*)couponType;
- (void)toCouponList;


@end
