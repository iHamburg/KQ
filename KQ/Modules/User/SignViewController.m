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
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithImageName:@"icon_back.png" target:self action:@selector(backPressed:)]];
    
    self.navigationItem.leftBarButtonItem = bb;
    
    self.view.backgroundColor = kColorBG;
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
      _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_scrollView];

    _network = [NetworkClient sharedInstance];
    
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
    
    cell.textLabel.text = @"abc";
    
    return cell;
    
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

@end
