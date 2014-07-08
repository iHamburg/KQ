//
//  KQViewController.h
//  
//
//  Created by AppDevelopper on 14-6-27.
//
//
#import "UserController.h"
#import "KQRootViewController.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "ConfigCell.h"
#import "CouponManager.h"


@interface KQViewController : UITableViewController{
    KQRootViewController *_root;
    UserController *_userController;
    NetworkClient *_networkClient;
    LibraryManager *_libraryManager;
    CouponManager *_manager;
}

@property (nonatomic, strong) KQRootViewController *root;
@property (nonatomic, strong) UserController *userController;

@end
