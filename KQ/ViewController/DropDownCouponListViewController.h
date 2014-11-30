//
//  SearchResultsViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "DropDownListViewController.h"

@interface DropDownCouponListViewController : DropDownListViewController<UISearchBarDelegate>{

    UISearchBar *_searchBar;
}

@property (nonatomic, strong) NSString *keyword;

- (void)pushCouponDetails:(Coupon*)coupon;

@end
