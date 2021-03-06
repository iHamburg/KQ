//
//  ShopViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "ShopBranchesCell.h"
#import "CouponListCell.h"
#import "ShopBranchListViewController.h"
#import "CouponDetailsViewController.h"
#import "MapViewController.h"



#pragma mark - ShopDescCell

@interface ShopDescCell : ConfigCell{
    UIButton *_favoritedBtn;
}
@property (nonatomic, strong) UIButton *favoritedBtn;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, copy) VoidBlock toggleBlock;

- (IBAction)toggleFavorite:(id)sender;

@end

@implementation ShopDescCell

- (void)setValue:(Shop*)shop{
    
    _value = shop;
    //    NSLog(@"shop.poster # %@",shop.posterUrl);
    
   
//    if (!ISEMPTY(shop.title)) {
//        self.firstLabel.text = shop.title;
//    }

    if (!ISEMPTY(shop.desc)) {
        self.secondLabel.text = shop.desc;
    }

    CGFloat height = [ShopDescCell cellHeightWithValue:shop];
    self.secondLabel.frame = CGRectMake(10, 45, 300, height);

}

- (void)setFavorited:(BOOL)favorited{
    _favorited = favorited;
    
    if (favorited) {
        [self.favoritedBtn setBackgroundImage:[UIImage imageNamed:@"coupon_favorited.png"] forState:UIControlStateNormal];
    }
    else{
        [self.favoritedBtn setBackgroundImage:[UIImage imageNamed:@"coupon_unfavorited.png"] forState:UIControlStateNormal];
    }

}

- (void)load{
    [super load];
    
    NSLog(@"shopDescCell load");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"refreshFavoritedShops" object:nil queue:nil usingBlock:^(NSNotification *note) {
        BOOL isFavorited = [note.object boolValue];
        
        __weak ShopDescCell *cell = self;
        cell.favorited = isFavorited;
        
    
    }];
    
    
    _firstLabel.frame = CGRectMake(10, 0, 250, 45);
    _firstLabel.numberOfLines = 0;
    _firstLabel.text = @"商户介绍";
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 45, _w, 1)];
    v.backgroundColor = kColorLightGray;
    

    [self addSubview:v];

    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(260, 5, 1, 35)];
    v2.backgroundColor = kColorLightGray;
    
    [self addSubview:v2];

    
    _secondLabel.numberOfLines = 0;
    _secondLabel.font = nFont(12);
    _secondLabel.textColor = kColorGray;
    
    UIButton *b = [UIButton buttonWithFrame:CGRectMake(275, 7, 30, 30) title:nil imageName:nil target:self action:@selector(toggleFavorite:)];

    _favoritedBtn = b;
    [_favoritedBtn setBackgroundImage:[UIImage imageNamed:@"coupon_unfavorited.png"] forState:UIControlStateNormal];

    [self addSubview:b];
}

- (IBAction)toggleFavorite:(id)sender{
    self.toggleBlock();
}

- (void)dealloc{
    L();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (CGFloat)cellHeightWithValue:(Shop*)shop{
    
//        NSLog(@"shop # %@",self.va)
    NSString *text = shop.desc;
    
    CGSize constraint = CGSizeMake(300, 10000);
    
    CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:nFont(12)} context:nil];
    
    return textRect.size.height + 20; // 加header的高度
   
}

@end


#pragma mark -
#pragma mark - ShopDetailsViewController


@implementation ShopDetailsViewController

- (NSArray*)coupons{
    
    return _shop.coupons;
    
}

- (void)setShop:(Shop *)shop{
    _shop = shop;
  
    [self.tableView reloadData];
    
    [_networkClient queryShopBranch:shop.id block:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [ErrorManager alertError:error];
            return;
        }
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        
//        NSLog(@"shop # %@",dict);
        
        Shop *shop = [[Shop alloc] initWithShopDetailsDict:dict];
        _shop = shop;
        
        [self.tableView reloadData];
    }];
   

    ///判断coupon是否已经收藏
    if ([_userController isLogin]) {
        ///判断coupon是否已经收藏
        
        
        [_networkClient queryIfFavoritedShop:_userController.uid shopId:shop.id block:^(NSDictionary *dict, NSError *error) {
            
            if (error) {
                [ErrorManager alertError:error];
                return ;
            }
            
            self.shopFavorited = [dict[@"result"] boolValue];
        }];
    }


    
}

- (void)setShopFavorited:(BOOL)isShopFavorited{
    _shopFavorited = isShopFavorited;
    
    //发送Notification
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedShops" object:[NSString stringWithInt:self.shopFavorited]];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.config = [[TableConfiguration alloc] initWithResource:@"ShopDetailsConfig"];

//    self.title = self.shop.title;

    self.title = @"商户详情";
    
    // 因为有动态的cell（coupons），所以分割线也错位了，
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
     [MobClick beginLogPageView:@"ShopDetails"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
}

#pragma mark - IBAction

- (IBAction)favoritePressed:(id)sender{
    L();
    [self toggleFavoriteShop:self.shop];
}
#pragma mark - TableView

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    float height = 1;
    if (section == 0) {
        height = 243;
    }
    
    return height;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _w, 243)];
        v.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _w, 196)];
        [imgV setImageWithURL:[NSURL URLWithString:_shop.logoUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgV.frame), 250, 45)];
        titleL.numberOfLines = 0;
        titleL.text = ISEMPTY(_shop.title)?@"":_shop.title;
        titleL.font = bFont(15);
        titleL.textColor = kColorBlack;
        
        UILabel *distanceL = [[UILabel alloc] initWithFrame:CGRectMake(260, CGRectGetMaxY(imgV.frame), 50, 45)];
        distanceL.textColor = kColorYellow;
        distanceL.font = bFont(12);
        NSString *distance = [_manager distanceStringFromLocation:_shop.location];
        distanceL.text = ISEMPTY(distance)?@"":distance;
        
        distanceL.textAlignment = NSTextAlignmentRight;
        
   
        
        [v addSubview:imgV];
        [v addSubview:titleL];
        [v addSubview:distanceL];
        
        [v addBottomLine:kColorLightGray];
        return v;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int row = [super tableView:tableView numberOfRowsInSection:section];
    
    if (section == 1) {
        row = _shop.coupons.count;

    }
    
    return row;
}

//- (float)ta

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
//        height = [ShopHeaderCell cellHeightWithValue:self.shop];
        height = 96;
    }
    else if(indexPath.section == 2){
        height = [ShopDescCell cellHeightWithValue:_shop] + 45;
    }
//    NSLog(@"index # %d,%d, height # %f",indexPath.section,indexPath.row,height);
    
    return height;
}




- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

   
    
    int section = indexPath.section;
    int row = indexPath.row;
    if (section == 0) {
     
        if (row < 3) {
            cell.textLabel.textColor = kColorGray;
            cell.textLabel.font = nFont(13);
            cell.textLabel.numberOfLines = 0;
            [cell addBottomDottedLine];
        }
        else{
            cell.textLabel.textColor = kColorBlack;
            cell.textLabel.font = bFont(15);
            [cell addBottomLine:kColorLightGray];
        }
        if (row != 2) {
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if ([cell isKindOfClass:[CouponListCell class]]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([cell isKindOfClass:[ShopDescCell class]]){
     
        __weak ShopDetailsViewController *vc = self;
        ShopDescCell *aCell = (ShopDescCell*)cell;
        aCell.toggleBlock = ^{
           
            [vc toggleFavoriteShop:vc.shop];

        };
    }
}


- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{
 
    int section = indexPath.section;
    
    if (section == 0) {
        if ([cell.key isEqualToString:@"address"]) {
            cell.textLabel.text = ISEMPTY(_shop.address)?@"":[NSString stringWithFormat:@"%@",_shop.address];
            cell.imageView.image = [UIImage imageNamed:@"address_loc_gray_icon.png"];


        }
        else if([cell.key isEqualToString:@"phone"]){
            cell.textLabel.text = ISEMPTY(_shop.phone)?@"联系电话:":[NSString stringWithFormat:@"联系电话: %@",_shop.phone];
             cell.imageView.image = [UIImage imageNamed:@"phone_icon.png"];


        }
        else if([cell.key isEqualToString:@"openTime"]){
            cell.textLabel.text = ISEMPTY(_shop.openTime)?@"营业时间:":[NSString stringWithFormat:@"营业时间: %@",_shop.openTime];
             cell.imageView.image = [UIImage imageNamed:@"opentime_icon.png"];
//            [cell addBottomDottedLine];

        }
        else if([cell.key isEqualToString:@"shoplist"]){
            cell.textLabel.text = [NSString stringWithFormat:@"查看全部%@家商户",_shop.shopCount];
//             [cell addBottomLine:kColorLightGray];
        }
    }

    if([cell isKindOfClass:[CouponListCell class]]){
        CouponListCell *aCell = (CouponListCell*)cell;
        
        if (!ISEMPTY(self.coupons)) {
            Coupon *coupon = self.coupons[indexPath.row];
            [aCell setValue:coupon];
            [cell addBottomLine:kColorLightGray];
        }
        
    }
    else if([cell isKindOfClass:[ShopDescCell class]]){
        cell.value = _shop;
        [(ShopDescCell*)cell setFavorited:self.shopFavorited];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    if (indexPath.section == 0) {
        if (row == 0) {
            [self toMap];
        }
        else if(row == 1){
            [self dial:_shop.phone];
        }
        else if (row == 3){
            [self toShopList];
        }
    }
    else if (indexPath.section == 1) {
        // coupon
        
        Coupon *coupon = self.coupons[indexPath.row];
        [self toCouponDetails:coupon];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns


- (void)toggleFavoriteShop:(Shop*)shop{
    
    if (!_userController.isLogin) {
       
        [_root presentLoginWithBlock:^(BOOL succeeded, NSError *error) {
            
        }];
        
        return;
    }

    
    if (self.shopFavorited) {
        [self unfavoriteShop:shop];
    }
    else{
        [self favoriteShop:shop];
    }
}
- (void)favoriteShop:(Shop*)shop{

    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken favoriteShop:shop.id block:^(id obj, NSError *error) {
        
        if (error) {
            [ErrorManager alertError:error];
            return ;
        }

        [_libraryManager startHint:@"收藏成功"];
        self.shopFavorited = YES;

    }];

}
- (void)unfavoriteShop:(Shop*)shop{

    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken unfavoriteShop:shop.id block:^(id obj, NSError *error) {
        
        if (error) {
            [ErrorManager alertError:error];
            return ;
        }

        [_libraryManager startHint:@"取消收藏"];
        self.shopFavorited = NO;
        
    }];
}

- (void)toShopList{
    ShopBranchListViewController *vc = [[ShopBranchListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.headerShopId = _shop.parentId; // 传递总店的id
    
//    vc.models = [self.shopBranches mutableCopy];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)toMap{
    MapViewController *vc = [[MapViewController alloc] init];
    vc.view.alpha = 1;
    vc.shop = _shop;

    [self.navigationController pushViewController:vc animated:YES];

}

- (void)dial:(NSString *)phone{
    
    
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
    
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    
    
    [[UIApplication sharedApplication] openURL:url];
}

- (void)toCouponDetails:(id)coupon{
   
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    
    [self.navigationController pushViewController:vc animated:YES];

}

//

@end
