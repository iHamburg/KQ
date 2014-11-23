//
//  CouponSearchViewController.h
//  KQ
//
//  Created by Forest on 14-11-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"
#import "CouponManager.h"
#import "KQRootViewController.h"
#import "CouponType.h"

@interface CouponSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>{

    UserController *_userController;  // 用户控制器
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
    CouponManager *_manager;
    
    KQRootViewController *_root;
    
    UISearchBar *_searchBar;
    
    UITableView *_leftV, *_rightV;
    
    NSMutableArray *_models;
    BOOL _networkFlag;

}


@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) CouponType *couponType;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSArray *searchTypes;
@property (nonatomic ,strong) NSMutableDictionary *searchParams;

/**
 *	@brief	清空原本的内容，从新载入内容
 */
- (void)loadModels;


/**
 *	@brief	加载更多
 *
 *	@param 	finishedBlock 	当完成的时候调用
 */
- (void)loadMore:(VoidBlock)finishedBlock;

- (void)toCouponDetails:(Coupon*)coupon;

@end
