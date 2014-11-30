//
//  MKSearchViewController.m
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)setSearchType:(int)searchType{
    _searchType = searchType;
    
    if (_searchType == 0) {
        [self searchDistrict];
    }
    else if(_searchType == 1){
        [self searchCouponType];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索";
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
    self.listContent = [@[@"1",@"2",@"3",@"4"] mutableCopy];
    
    self.filteredListContent = [NSMutableArray array];
    
    UISearchBar * theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-50, 40)];
    
    theSearchBar.placeholder = @"enter province name";
    
    theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    theSearchBar.delegate = self;
    
//    self.tableView.tableHeaderView = theSearchBar;
    _searchBar = theSearchBar;
    
    searchdispalyCtrl = [[UISearchDisplayController  alloc] initWithSearchBar:theSearchBar contentsController:self];

    searchdispalyCtrl.delegate = self;
    
    searchdispalyCtrl.searchResultsDelegate=self;
    
    searchdispalyCtrl.searchResultsDataSource = self;

//    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"按地区找",@"按分类找"]];
//    
//    seg.frame = CGRectMake(0, 0, 160, 30);
//    seg.selectedSegmentIndex = 0;
//    [seg addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = seg;

    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.view.frame = CGRectMake(0, 50, 320, 300);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, _h)];
    v.backgroundColor = [UIColor redColor];
    [self.view.superview addSubview:v];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)segmentChanged:(UISegmentedControl*)sender{
    self.searchType = sender.selectedSegmentIndex;
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _searchBar;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else
    {
        return 2;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
  
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        //NSLog(@"filterContent");
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        [self configResultsCell:cell indexPath:indexPath];
    }
    else
    {
        //NSLog(@"listContent");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [self configCell:cell indexPath:indexPath];
    }
    
//    cell.textLabel.text = @"111";
    
    return cell;
}

- (void)configResultsCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{

    
    cell.textLabel.text = @"111";
}

- (void)configCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    if (indexPath.section == 0) {
        
    }
    
    cell.textLabel.text = @"222";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //    NSLog(@"filterContent for search Text searchText:%@,scope:%@",searchText,scope);
    
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (NSString* product in _listContent)
    {
        
        NSComparisonResult result = [product compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            NSLog(@"find something");
            [self.filteredListContent addObject:product];
        }
    }
    
    //或者用Predicate
    // Filter the array using NSPredicate
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    //    NSArray *array = [self.listContent filteredArrayUsingPredicate:predicate];
    //    NSLog(@"array # %@",array);
    //
    //    self.filteredListContent = [array mutableCopy];
    //
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Fcns
- (void)searchDistrict{
    L();
    ///改变hotsearch的标签
}
- (void)searchCouponType{
    L();
}

@end
