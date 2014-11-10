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
    
}

@property (nonatomic, strong) TableConfiguration *config;
@property (nonatomic, strong) UserController *userController;


- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath; //开始只调用一次的cell配置
- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;     //每次reload table都会调用的cell配置


@end
