//
//  SignViewController.h
//  
//
//  Created by Forest on 14-9-11.
//
//
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "UserController.h"
#import "KQRootViewController.h"

@interface SignViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    
    
    UIScrollView *_scrollView;
    UITableView *_tableView;
    
    NSArray *_tfs, *_tableImageNames;
    
    UIButton *_submitBtn;

    NetworkClient *_network;
    LibraryManager *_libraryMng;
    UserController *_userController;
    KQRootViewController *_root;
    
    BOOL _networkFlag;
    BooleanResultBlock _successBlock;
}

@property (nonatomic, assign) BOOL networkFlag;
@property (nonatomic, copy) BooleanResultBlock successBlock;

- (IBAction)backPressed:(id)sender;
- (IBAction)submitClicked:(id)sender;

/**
 *	@brief 默认的返回方式是pop回上一层
 */
- (void)back;

- (void)submit;


- (void)willConnect:(UIView*)sender; // 一次应该只loading一个view
- (void)willDisconnect;

@end
