//
//  MKViewController.h
//  Makers
//
//  Created by AppDevelopper on 14-5-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "TableConfiguration.h"
#import "UserController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"
#import "CouponManager.h"
#import "KQRootViewController.h"

@interface ConfigViewController : UITableViewController{

    TableConfiguration *_config;    // Table配置文件
    
    UserController *_userController;  // 用户控制器
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
    CouponManager *_manager;
    
    KQRootViewController *_root;
    
    BOOL _networkFlag;
    
}

@property (nonatomic, assign) BOOL networkFlag;
@property (nonatomic, strong) TableConfiguration *config;


- (IBAction)backPressed:(id)sender;

/**
 *	@brief	只调用一次的cell配置, 调用完之后会吧cell的isInited参数修改成true，这样以后的reloadData，该cell就不会再调用initConfig函数了
 *
 */
- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

/**
 *	@brief	每次reload table都会调用的cell配置

 */
- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;


- (void)willConnect:(UIView*)sender; // 一次应该只loading一个view
- (void)willDisconnect;

@end
