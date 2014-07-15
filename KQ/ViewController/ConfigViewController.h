//
//  MKViewController.h
//  Makers
//
//  Created by AppDevelopper on 14-5-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRootViewController.h"
#import "TableConfiguration.h"
#import "UserController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"
#import "CouponManager.h"

@interface ConfigViewController : UITableViewController{

    TableConfiguration *_config;
    KQRootViewController *_root;
    UserController *_userController;
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
    CouponManager *_manager;
    

}

@property (nonatomic, strong) TableConfiguration *config;
@property (nonatomic, strong) KQRootViewController *root;
@property (nonatomic, strong) UserController *userController;


- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;
- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;


@end
