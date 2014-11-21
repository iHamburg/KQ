//
//  NetTableViewController.m
//  
//
//  Created by AppDevelopper on 14-5-28.
//
//

#import "NetTableViewController.h"


@implementation NetTableViewController

- (void)setIsLoadMore:(BOOL)isLoadMore{

    _isLoadMore = isLoadMore;
    if (isLoadMore == NO) {
        [_loadMoreFooterView removeFromSuperview];
//        _loadMoreFooterView = nil;
    }
    else{
        [self.tableView addSubview:_loadMoreFooterView];
    }
}

- (NSMutableArray*)models{
    if (!_models) {
        _models = [NSMutableArray array];

    }
    return _models;
}

- (void)viewDidLoad{
    [super viewDidLoad];
   
    
    if (_loadMoreFooterView == nil) {
        
        LoadMoreTableFooterView *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, self.tableView.contentSize.height, self.tableView.frame.size.width, 30)];
        view.delegate = self;
//		[self.tableView addSubview:view];
		_loadMoreFooterView = view;

       
	}
    
    self.isLoadMore = YES;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // iOS8 的seperator错位问题
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ///如果在willappear时models为空，重新载入models
    if (ISEMPTY(self.models)) {
        [self loadModels];
    }
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}

#pragma mark - Table view data source

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    [self addSeparatorLineInCell:cell];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.


    if ([_config isDynamicSection:section]) {
        return [self.models count];
    }
    else{
       return [_config numberOfRowsInSection:section];
    }
    
}




#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	[_loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
//    NSLog(@"didi scroll # %@",_loadMoreFooterView);
    
	[_loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //        NSLog(@"did end trigger");
	
	[_loadMoreFooterView loadMoreScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark LoadMoreTableFooterDelegate Methods

- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view {
    
//    NSLog(@"Did Trigger");
    
	[self reloadTableViewDataSource];

    [self loadMore:^{
        [self doneLoadingTableViewData];
    } ];
}

- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view {
	return _reloading;
}

#pragma mark - IBAction
- (IBAction)RefreshViewControlEventValueChanged:(id)sender{
    
    [self loadModels];
}

#pragma mark -

- (void)loadModels{

    
}

- (void)loadMore:(VoidBlock)block{
    
}

- (void)addSeparatorLineInCell:(UITableViewCell*)cell{
    UIView *separatorV = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height, cell.width, 1)];
    separatorV.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    [cell addSubview:separatorV];
}
@end
