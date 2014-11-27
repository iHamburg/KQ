//
//  SignViewController.m
//  
//
//  Created by Forest on 14-9-11.
//
//

#import "SignViewController.h"

@implementation SignViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_white_back.png" target:self action:@selector(backPressed:)]];
    
    self.navigationItem.leftBarButtonItem = bb;
    
    self.view.backgroundColor = kColorBG;
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
      _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_scrollView];

    _network = [NetworkClient sharedInstance];
    _libraryMng = [LibraryManager sharedInstance];
    _userController = [UserController sharedInstance];
    _root = [KQRootViewController sharedInstance];
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    
    self.networkFlag = NO;
    [self willDisconnect];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    else{
        return 4;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier1 = @"Cell1";
    
    //
    
    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
    
//    cell.textLabel.text = @"abc";
    
    return cell;
    
}




//确保分割线左边顶头
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


#pragma mark - IBAction
- (IBAction)backPressed:(id)sender{
    
    [self back];
    
}

- (IBAction)submitClicked:(id)sender{
    [self submit];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)submit{
    
}

- (void)willConnect:(UIView*)sender{
    
    
    [_libraryMng startLoadingInView:sender];
    self.networkFlag = YES;

    
}

- (void)willDisconnect{
    
    [_libraryMng stopLoading];
    
}



@end
