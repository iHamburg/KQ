//
//  MKSearchViewController.h
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>{
    
    UISearchDisplayController * searchdispalyCtrl;
    
    UISearchBar *_searchBar;
}



@property (nonatomic, strong) NSMutableArray *listContent;
@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) int searchType;

- (IBAction)segmentChanged:(id)sender;

- (void)searchDistrict;
- (void)searchCouponType;

@end
