//
//  CouponListViewController.m
//  
//
//  Created by AppDevelopper on 14-6-28.
//
//

#import "DropDownListViewController.h"
#import "CouponType.h"
#import "District.h"

#import "KQRootViewController.h"
#import "CouponDetailsViewController.h"
#import "ShopListCell.h"

@interface DropDownListViewController ()

//- (void)addCouponsInModels:(NSArray *)array;
- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params;

@end

@implementation DropDownListViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.couponTypeIndex = 0;
    self.districtIndex = 0;
    self.orderIndex = 0;
    self.searchParams = [NSMutableDictionary dictionary];
    
    self.couponTypes = _manager.searchCouponTypes;
    self.districts = _manager.searchDistricts;
    self.orders = @[@"智能排序",@"离我最近"];
    
//    NSLog(@"coupontypes # %@",self.couponTypes);
    
    /// init DropDownView
//    NSMutableArray *typeTitles = [NSMutableArray arrayWithCapacity:self.couponTypes.count];
//
//    for (CouponType *type in self.couponTypes) {
//        [typeTitles addObject:type.title];
//    }
//    
//    
//    NSMutableArray *districtTitles = [NSMutableArray arrayWithCapacity:self.districts.count];
////    [districtTitles addObject:@"全部商区"];
//    for (District *obj in self.districts) {
//        [districtTitles addObject:obj.title];
//    }
    
    
//    self.dropDownArray = [NSMutableArray arrayWithArray:@[
//                                                          typeTitles,
//                                                          districtTitles,
//                                                          self.orders
//                                                          ]];
    
    _dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, 320, 40) dataSource:self delegate:self];

    
    //???一定要是root的view吗？
    _dropDownView.mSuperView = [[KQRootViewController sharedInstance]view];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

#pragma mark - dropDownListDelegate

/// 只要点击选项就重载tableview
-(void) chooseAtSection:(int)section index:(int)index
{
    
//    NSLog(@"选了section:%ld ,index:%ld",(long)section,(long)index);
  
    if (section == 0) {
        //type
        self.couponTypeIndex = index;
    }
    else if(section == 1){
        self.districtIndex = index;
    }
    else{
        // order
        self.orderIndex = index;
    }
    
    
    [self loadModels];
}


-(NSInteger)numberOfSections
{
    return [_dropDownArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =_dropDownArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return _dropDownArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}



#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _dropDownView;
    
}
- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"config cell # %@",[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row ]);
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    if ([cell isKindOfClass:[ShopListCell class]]) {
        
        Shop *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self toCouponDetails:self.models[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns


- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params{
    
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [params setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [params setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
}

//int nearestSort(Coupon* obj1, Coupon* obj2, void *context ) {
//    // returns random number -1 0 1
//    return obj1.nearestDistance - obj2.nearestDistance;
//}
@end
