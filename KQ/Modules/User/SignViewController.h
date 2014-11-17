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

@interface SignViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    
    
    UIScrollView *_scrollView;
    UITableView *_tableView;
    
    NSArray *_tfs, *_tableImageNames;
    
    UIButton *_submitBtn;

    NetworkClient *_network;
    LibraryManager *_libraryMng;
    UserController *_userController;
    BOOL _networkFlag;
    
//    UIView *_connectSender;
}

@property (nonatomic, assign) BOOL networkFlag;

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
