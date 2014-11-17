//
//  MKViewController.m
//  Makers
//
//  Created by AppDevelopper on 14-5-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"


@interface ConfigViewController ()

@end

@implementation ConfigViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    _userController = [UserController sharedInstance];
    _networkClient = [NetworkClient sharedInstance];
    _libraryManager = [LibraryManager sharedInstance];
    _manager = [CouponManager sharedInstance]; //需要调用HUD，必须等root已经有view
    _root = [KQRootViewController sharedInstance];
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    self.view.backgroundColor = kColorBG;

    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

//    NSLog(@"table.contentSize # %f",self.tableView.contentSize.height);
    


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _config.numberOfSections;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [_config headerInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSInteger rowCount = [_config numberOfRowsInSection:section];
    
    
    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_config heightForRowInSection:indexPath.section];

    if (height>0) {

        return height;
    }
    else
        return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    
    NSString *cellClassName = [_config cellClassnameForIndexPath:indexPath];
    if (ISEMPTY(cellClassName)) {
        cellClassName = @"ConfigCell";
    }
    NSString *identifier = [_config cellIdentifierInSection:indexPath.section];

    
    UINib *nib = _config.nibs[indexPath.section];
    if ([nib isKindOfClass:[UINib class]]) {
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
    }
    else{
        [tableView registerClass:[NSClassFromString(cellClassName) class] forCellReuseIdentifier:identifier];

    }
    
    
    ConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
//    NSLog(@"className # %@,identifier %@,cell # %@",cellClassName,identifier,cell);
    
    cell.key = [_config keyForIndexPath:indexPath];
    // 只要有label，就会显示在textLabel上！但如果是textfieldCell，textLabel会被盖到下面去不显示
    cell.textLabel.text = [_config labelForIndexPath:indexPath];

    NSString *imgName = [_config imageNameForIndexPath:indexPath];
    
    if (!ISEMPTY(imgName)) {
        cell.imageView.image = [UIImage imageNamed:imgName];
    }

    /// 对cell进行初始设置，和多个model无关。 先调用textLabel再调用initConfigCell
    if (!cell.isInited) {
        [self initConfigCell:cell atIndexPath:indexPath];
        cell.isInited = YES;
    }
    
    
    [self configCell:cell atIndexPath:indexPath];
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SEL selector = [self.config selectorForIndexPath:indexPath];
    
//    NSLog(@"selector # %@",NSStringFromSelector(selector));
    
    if (!ISEMPTY(NSStringFromSelector(selector))) {
        [self performSelector:selector withObject:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


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

- (void)initConfigCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{}

- (void)configCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{}



@end
