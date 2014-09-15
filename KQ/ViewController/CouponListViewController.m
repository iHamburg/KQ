//
//  CouponListViewController.m
//  
//
//  Created by AppDevelopper on 14-6-28.
//
//

#import "CouponListViewController.h"
#import "CouponType.h"
#import "District.h"
#import "AVOSEngine.h"
#import "KQRootViewController.h"
#import "CouponDetailsViewController.h"

@interface CouponListViewController ()

- (void)addCouponsInModels:(NSArray *)array;
- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params;

@end

@implementation CouponListViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.couponTypeIndex = 0;
    self.districtIndex = 0;
    self.orderIndex = 0;
    self.searchParams = [NSMutableDictionary dictionary];
    
    self.couponTypes = _manager.couponTypes;
    self.districts = _manager.districts;
    self.orders = @[@"离我最近"];
    
    /// init DropDownView
    NSMutableArray *typeTitles = [NSMutableArray arrayWithCapacity:self.couponTypes.count];
    [typeTitles addObject:@"全部类型"];
    for (CouponType *type in self.couponTypes) {
        [typeTitles addObject:type.title];
    }
    
    
    NSMutableArray *districtTitles = [NSMutableArray arrayWithCapacity:self.districts.count];
    [districtTitles addObject:@"全部商区"];
    for (District *obj in self.districts) {
        [districtTitles addObject:obj.title];
    }
    
    
    self.dropDownArray = [NSMutableArray arrayWithArray:@[
                                                          typeTitles,
                                                          districtTitles,
                                                          self.orders
                                                          ]];
    
    dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,0, 320, 40) dataSource:self delegate:self];
    
    //???一定要是root的view吗？
    dropDownView.mSuperView = [[KQRootViewController sharedInstance]view];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

#pragma mark - dropDownListDelegate

/// 只要点击选项就重载tableview
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    
    NSLog(@"选了section:%d ,index:%d",section,index);
  
    if (section == 0) {
        //type
        self.couponTypeIndex = index;
    }
    else if(section == 1){
        self.districtIndex = index;
    }
    else{
        self.orderIndex = index;
    }
    
    [self.models removeAllObjects];
    [self.tableView reloadData];
    
    [self loadModels];
}

#pragma mark -- dropdownList DataSource
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
    
    return dropDownView;
    
}
- (void)configCell:(CouponListCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"config cell # %@",[NSString stringWithFormat:@"%d,%d",indexPath.section,indexPath.row ]);
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        
        Coupon *project = _models[indexPath.row];
        
        [cell setValue:project];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self toCouponDetails:self.models[indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns

- (void)loadModels{
    
    
    
    [_libraryManager startProgress:nil];
    
    [self.models removeAllObjects];
    
    [self.searchParams removeAllObjects];
    

    
    if (self.couponTypeIndex>0) {
        CouponType *obj = self.couponTypes[self.couponTypeIndex-1];
        
        [self.searchParams setObject:obj.id forKey:@"couponTypeId"];
    }
    
    if (self.districtIndex > 0) {
        District *obj = self.districts[self.districtIndex-1];

        [self.searchParams setObject:obj.id forKey:@"districtId"];
    }
    
    [self addCurrentLocationToSearchParams:self.searchParams];
    
    
    NSLog(@"param # %@", self.searchParams);
    
    [_networkClient searchCoupons:self.searchParams block:^(NSArray *array, NSError *error) {
        [_libraryManager dismissProgress:nil];
        
        if (ISEMPTY(array)) {
            
            [_libraryManager startHint:@"暂时还没有结果" duration:1];
        }else{
            
            [self addCouponsInModels:array];

        }
        
    }];
}


- (void)loadMore:(VoidBlock)finishedBlock{

    int skip = [_models count];

    /// param没有改变，只是增加了skip
    [self.searchParams setValue:[NSString stringWithInt:skip] forKey:@"skip"];
    
    [_networkClient searchCoupons:self.searchParams block:^(NSArray *array, NSError *error) {
        [_libraryManager dismissProgress:nil];
        
        if (ISEMPTY(array)) {
            
            [_libraryManager startHint:@"暂时还没有结果" duration:1];
        }else{
            
            [self addCouponsInModels:array];
            
            finishedBlock();
        }
        
    }];

}




- (void)toCouponDetails:(Coupon*)coupon{
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] init];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)addCurrentLocationToSearchParams:(NSMutableDictionary*)params{
    
    CLLocationCoordinate2D coord = _userController.checkinLocation.coordinate;
    [params setObject:[NSString stringWithFormat:@"%f",coord.latitude] forKey:@"latitude"];
    [params setObject:[NSString stringWithFormat:@"%f",coord.longitude] forKey:@"longitude"];
}

- (void)addCouponsInModels:(NSArray *)array {
    //            NSLog(@"search results # %@",array);
    
    for (NSDictionary *dict in array) {
        if (!ISEMPTY(dict)) {
            ///如果coupon已经在models,就不加这个coupon
            BOOL flag = YES;
            for (Coupon *coupon in self.models) {
                if ([coupon.id isEqualToString:dict[@"objectId"]]) {
                    flag = NO;
                    break;
                }
            }
            if (flag == NO) {
                continue;
            }
            
            Coupon *coupon = [Coupon couponWithDict:dict];
            coupon.nearestDistance = [_userController distanceFromLocation:coupon.nearestLocation];
            
            [self.models addObject:coupon];
        }
    }
    
    [self.tableView reloadData];
}

int nearestSort(Coupon* obj1, Coupon* obj2, void *context ) {
    // returns random number -1 0 1
    return obj1.nearestDistance - obj2.nearestDistance;
}
@end
