//
//  SignViewController.h
//  
//
//  Created by Forest on 14-9-11.
//
//
#import "NetworkClient.h"

@interface SignViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NetworkClient *_network;
    
    UIScrollView *_scrollView;
    UITableView *_tableView;
    
    NSArray *_tfs, *_tableImageNames;
    
    UIButton *_submitBtn;

}

- (IBAction)backPressed:(id)sender;
- (IBAction)submitClicked:(id)sender;

- (void)back;
- (void)submit;

@end
