//
//  MKViewController.h
//  Makers
//
//  Created by AppDevelopper on 14-5-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TableConfiguration.h"


#import "KQViewController.h"

@interface ConfigViewController : KQViewController{

    TableConfiguration *_config;
//    KQRootViewController *_root;
//    UserController *_userController;
//    NetworkClient *_networkClient;
//    LibraryManager *_libraryManager;
//    CouponManager *_manager;
    

}

@property (nonatomic, strong) TableConfiguration *config;


- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;
- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;


@end
