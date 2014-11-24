//
//  CouponListViewController.h
//  
//
//  Created by AppDevelopper on 14-6-28.
//
//

#import "NetTableViewController.h"
#import "DropDownChooseProtocol.h"
#import "CouponListCell.h"
#import "DropDownListView.h"
//#import "<#header#>"

@interface DropDownListViewController : NetTableViewController<DropDownChooseDelegate,DropDownChooseDataSource>{

    DropDownListView *_dropDownView;
    NSMutableDictionary *_searchParams;
}


@property (nonatomic, strong) NSArray *dropDownArray;

@property (nonatomic, strong) NSArray *couponTypes;
@property (nonatomic, strong) NSArray *districts;
@property (nonatomic, strong) NSArray *orders;

@property (nonatomic, assign) int couponTypeIndex;
@property (nonatomic, assign) int districtIndex;
@property (nonatomic, assign) NSInteger orderIndex;
@property (nonatomic, strong) NSMutableDictionary *searchParams;

@end
