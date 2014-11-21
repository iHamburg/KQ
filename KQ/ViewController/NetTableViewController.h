//
//  NetTableViewController.h
//  
//
//  Created by AppDevelopper on 14-5-28.
//
//

#import "ConfigViewController.h"
#import "LoadMoreTableFooterView.h"

@interface NetTableViewController : ConfigViewController<LoadMoreTableFooterDelegate>{

    NSMutableArray *_models;
    LoadMoreTableFooterView *_loadMoreFooterView;
    
	BOOL _reloading;
    BOOL _isLoadMore;
}

/**
 *	@brief	models 一种通过loadModels载入，另一种是外部指派。
 */
@property (nonatomic, strong) NSMutableArray *models;

@property (nonatomic, assign) BOOL isLoadMore;

/**
 *	@brief	下拉刷新
 *
 *	@param 	sender
 */
- (IBAction)RefreshViewControlEventValueChanged:(id)sender;


/**
 *	@brief	清空原本的内容，从新载入内容
 */
- (void)loadModels;


/**
 *	@brief	加载更多
 *
 *	@param 	finishedBlock 	当完成的时候调用
 */
- (void)loadMore:(VoidBlock)finishedBlock;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

/**
 *	@brief	iOS8 动态cell的分割线不对，所以手动添加
 *
 */
- (void)addSeparatorLineInCell:(UITableViewCell*)cell;


@end
