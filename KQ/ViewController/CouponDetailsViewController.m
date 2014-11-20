//
//  CouponDetaisViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponDetailsViewController.h"

#import "ShopBranchesCell.h"
#import "ShopModelDescCell.h"
#import "AutoHeightCell.h"

#import "UMSocial.h"
#import "UIImageView+WebCache.h"

#import "ImageButtonCell.h"
#import "AddCardViewController.h"
#import "ShopBranchListViewController.h"
#import "ShopDetailsViewController.h"
#import "MapViewController.h"
#import "AfterDownloadViewController.h"

#pragma mark - Cell: CouponHeader
@interface CouponHeaderCell : ConfigCell{

    IBOutlet UIButton *_downloadB, *_favoriteB;
    IBOutlet UIImageView *_bgV;
    IBOutlet UILabel *_downloadNumL;
  
}

@property (nonatomic, assign) BOOL hasFavoritedCoupon;
@property (nonatomic, copy) VoidBlock downloadBlock;
@property (nonatomic, copy) VoidBlock toggleFavoriteBlock;

- (IBAction)downloadPressed:(id)sender;
- (IBAction)favoriteToggled:(id)sender;


@end


@implementation CouponHeaderCell

// 180: 135 + 45

- (void)setValue:(Coupon*)coupon{
    

    _value = coupon;
    
    
    __weak id cell = self;
    
    [self.avatarV setImageWithURL:[NSURL URLWithString:coupon.avatarUrl] placeholderImage:[UIImage imageNamed:@"loading-pic02.png"] success:^(UIImage *image, BOOL cached) {
        
        Coupon *aCoupon = [(CouponHeaderCell*)cell value];
        [aCoupon setAvatar:image];
        
    } failure:^(NSError *error) {}];
    
    self.firstLabel.text = coupon.discountContent;
    self.secondLabel.text = coupon.title;
    self.thirdLabel.text = coupon.slogan;
    _downloadNumL.text = [NSString stringWithFormat:@"%@人",coupon.downloadedCount];
    
//    NSString *downloaded = coupon.downloadedCount;
//    if (ISEMPTY(downloaded)) {
//        downloaded = @"0";
//    }

//     = [NSString stringWithFormat:@"%@人购买",downloaded];

}

- (void)setHasFavoritedCoupon:(BOOL)hasFavoritedCoupon{

    _hasFavoritedCoupon = hasFavoritedCoupon;
    
    if (_hasFavoritedCoupon) {
        [_favoriteB setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_favoriteB setBackgroundImage:[UIImage imageNamed:@"bg_unfavoriteB.jpg"] forState:UIControlStateNormal];
    }
    else{
        [_favoriteB setTitle:@"收藏快券" forState:UIControlStateNormal];
        [_favoriteB setBackgroundImage:[UIImage imageNamed:@"bg_favoriteB.jpg"] forState:UIControlStateNormal];

    }
//    L();
}


- (void)load{
    [super load];

    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView removeFromSuperview];

    
    _downloadB.backgroundColor = kColorRed;
    _downloadB.layer.cornerRadius = 3;

    _firstLabel.textColor = kColorBlack;
    _secondLabel.textColor = kColorBlack;
    _thirdLabel.textColor = kColorBlack;
    
}

- (IBAction)downloadPressed:(id)sender{
    
    self.downloadBlock();
}

- (IBAction)favoriteToggled:(id)sender{
    
    _toggleFavoriteBlock();

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	
//    L();
//	NSLog(@"cell # %@",self);
	id newObject = [change objectForKey:NSKeyValueChangeNewKey];
	
	if ([NSNull null] == (NSNull*)newObject)
		newObject = nil;
    
	if ([keyPath isEqualToString:@"isFavoritedCoupon"]) {
        BOOL flag = [newObject boolValue];
      
        self.hasFavoritedCoupon = flag;
    }
	
}


@end

#pragma mark -

@interface CouponShortCell : ConfigCell

@end

@implementation CouponShortCell

- (void)setValue:(Coupon*)coupon{
    _value = coupon;
    
    self.textLabel.text = coupon.title;
    self.firstLabel.text = coupon.discountContent;
}

- (void)load{
    
    self.textLabel.frame = CGRectMake(10, 0, 125, 45);
    
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 165, 45)];
    

    [self addSubview:self.firstLabel];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}
@end

#pragma mark -
#pragma mark - CouponDetailsViewController

@interface CouponDetailsViewController (){
    
}

@end

@implementation CouponDetailsViewController


- (void)setCoupon:(Coupon *)coupon{
    
    L();
    
//    NSParameterAssert(coupon);
    
    _coupon = coupon;
    
    //如果用户已经登录, 查看coupon是否已经收藏
    if ([[UserController sharedInstance] isLogin]) {
        ///判断coupon是否已经收藏
    
        for (NSString *couponId in [[UserController sharedInstance]people].favoritedCouponIds) {
            
            //        NSLog(@"couponId # %@",couponId);
            if ([couponId isEqualToString:coupon.id]) {
                
                self.isFavoritedCoupon = YES;
                break;
            }
        }
    }
    
    
  
    /// 从CouponList过来，需要coupon的details
    self.networkFlag = YES;
    
    [_networkClient queryCoupon:coupon.id latitude:_userController.latitude longitude:_userController.longitude block:^(NSDictionary *dict, NSError *error) {
   
        if (!_networkFlag) {
            return ;
        }
        
        if (error) {
            [ErrorManager alertError:error];
            return;
        }
       
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
//        NSLog(@"coupon # %@",dict);
        Coupon *coupon = [[Coupon alloc] initWithDetailsDict:dict];
        _coupon = coupon;
        
//        NSLog(@"othercoupons # %@",_coupon.otherCoupons);

        [self.tableView reloadData];
    }];
    
}

#pragma mark - Init

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponModelConfig"];

    self.title = @"快券详情";
    
    
    UIBarButtonItem *shareBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_myfavoritedshops.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sharePressed:)];
    
    self.navigationItem.rightBarButtonItem = shareBB;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
    
}

#pragma mark - TableView

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int num = [super tableView:tableView numberOfRowsInSection:section];
    
    if (section == 5) {
        num = [self.coupon.shopCoupons count];
    }
    else if(section == 6){
        num = self.coupon.otherCoupons.count;
    }
    
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
//    NSLog(@"indexPath # %@",indexPath);
    
    if (indexPath.section == 2) {
      
        height = [AutoHeightCell cellHeightWithString:self.coupon.message font:[UIFont fontWithName:kFontName size:12]];
        
    }
    else if (indexPath.section == 3) {
        height = [AutoHeightCell cellHeightWithString:self.coupon.desc font:[UIFont fontWithName:kFontName size:12]];
        
    }
    else if (indexPath.section == 4) {
        height = [AutoHeightCell cellHeightWithString:self.coupon.notice font:[UIFont fontWithName:kFontName size:12]];
        
    }

    

    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    return 40;
}


- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    __weak CouponDetailsViewController *vc = self;
    
    
    if([cell isKindOfClass:[ShopBranchesCell class]]){
        
        ShopBranchesCell *aCell = (ShopBranchesCell*)cell;
        
        aCell.toMapBlock = ^(Shop* shop){
            
            [vc toMap];
        };
        
        aCell.toShopListBlock = ^{
            [vc toShopList];
        };
        
    }
    else if([cell isKindOfClass:[CouponHeaderCell class]]){
        
        [(CouponHeaderCell*)cell setValue:self.coupon];

        [(CouponHeaderCell*)cell setHasFavoritedCoupon:self.isFavoritedCoupon];
        CouponHeaderCell *aCell = (CouponHeaderCell*)cell;
        
        aCell.downloadBlock = ^{
            
            [vc downloadCoupon:self.coupon];
        
        };
        
        aCell.toggleFavoriteBlock = ^{
        
            [vc toggleFavoriteCoupon:self.coupon];
        
        };
        
        
        [self addObserver:cell forKeyPath:@"isFavoritedCoupon" options:NSKeyValueObservingOptionNew context:nil];
       
    }
   

}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    int section = indexPath.section;
    int row = indexPath.row;
    
     __weak CouponDetailsViewController *vc = self;
    
    if([cell isKindOfClass:[ShopBranchesCell class]]){
        
      
        [(ShopBranchesCell*)cell setValue:[self.shopBranches firstObject]];
        
        [(ShopBranchesCell*)cell setShopBranchesNum:[self.shopBranches count]];
 
        
    }
    else if([cell isKindOfClass:[CouponHeaderCell class]]){
        
    
        [(CouponHeaderCell*)cell setHasFavoritedCoupon:self.isFavoritedCoupon];
      
    }
    else if([cell isKindOfClass:[CouponHeaderCell class]]){
        
        [(CouponHeaderCell*)cell setValue:self.coupon];
        
        [(CouponHeaderCell*)cell setHasFavoritedCoupon:self.isFavoritedCoupon];
        CouponHeaderCell *aCell = (CouponHeaderCell*)cell;
        
        aCell.downloadBlock = ^{
            
            L();
            [vc downloadCoupon:self.coupon];
            
        };
        
        aCell.toggleFavoriteBlock = ^{
            
            [vc toggleFavoriteCoupon:self.coupon];
            
        };
        
        
        [self addObserver:cell forKeyPath:@"isFavoritedCoupon" options:NSKeyValueObservingOptionNew context:nil];
        
        
        
    }
    else if([cell isKindOfClass:[AutoHeightCell class]]){
        NSString *key = cell.key;
        [cell setValue:[self.coupon valueForKey:key]];
    }

    if (indexPath.section == 5) {
    // 商户快券
        if (ISEMPTY(self.coupon.shopCoupons)) {
            return;
        }
        Coupon *coupon = self.coupon.shopCoupons[row];
        [cell setValue:coupon];
    }
    else if(section == 6){
    // 其他快券
        
        Coupon *coupon = self.coupon.otherCoupons[row];
        [cell setValue:coupon];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConfigCell *cell = (ConfigCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[CouponShortCell class]]) {
        
        Coupon *coupon = cell.value;
        [self pushCoupon:coupon];
        
    }
    
}

#pragma mark - IBAction


///toCouponDetails, 按back之后没有实现
- (IBAction)backPressed:(id)sender{
    L();
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)sharePressed:(id)sender{
    
    [self shareCoupon:self.coupon];

    
}


#pragma mark - Fcns

- (void)downloadCoupon:(Coupon*)coupon{

//    NSLog(@"coupon # %@",coupon);
    //TODO: if
    if (!_userController.isLogin || YES) {
        //如果没有登录，让用户登录
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];
        
        
        return;
    
    }
    
 

         [_libraryManager startProgress:nil];
        
         [_networkClient user:_userController.uid downloadCoupon:coupon.id block:^(id obj, NSError *error) {

            [_libraryManager dismissProgress:nil];
            
             if (obj) {
                
                 
//                 if(!_userController.hasBankcard){
//                     // 如果用户没有银行卡
//                     
//                     [self toAfterDownload];
//                     
//                     
//                 }
                 
                [_libraryManager startHint:@"下载快券成功"];
            }
            
        }];
    
}

- (void)toggleFavoriteCoupon:(Coupon*)coupon{

    if (!_userController.isLogin) {
        [_libraryManager startHint:@"请先登录快券"];
        return;
    }

    
    if (self.isFavoritedCoupon) {
        [self unfavoriteCoupon:coupon];
    }
    else{
        [self favoriteCoupon:coupon];
    }
}
- (void)favoriteCoupon:(Coupon*)coupon{

    [_libraryManager startProgress:nil];
    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken favoriteCoupon:coupon.id block:^(id obj, NSError *error) {

            [_libraryManager dismissProgress:nil];
        
        if (obj) {
            [_libraryManager startHint:@"收藏成功"];

            self.isFavoritedCoupon = YES;
            
            [_userController.people.favoritedCouponIds addObject:coupon.id];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedCoupons" object:nil];
        }
    }];
    
}
- (void)unfavoriteCoupon:(Coupon*)coupon{
    
    [_libraryManager startProgress:nil];
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken unfavoriteCoupon:coupon.id block:^(id obj, NSError *error) {
        
        [_libraryManager dismissProgress:nil];

//        NSLog(@"did unfavorite");
        if (obj) {
            [_libraryManager startHint:@"取消收藏"];

            self.isFavoritedCoupon = NO;
            [_userController.people.favoritedCouponIds removeObject:coupon.id];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedCoupons" object:nil];
        }

    }];
}

- (void)shareCoupon:(Coupon*)coupon{
    
    UIImage *img = coupon.avatar;
    if (!img) {
        img = DefaultImg;
    }
    
    [_libraryManager shareWithText:coupon.title image:img delegate:self];
    
}

- (void)pushCoupon:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toShop{

    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] init];
    vc.view.alpha = 1.0;
    vc.shop = self.shop;
    vc.shopBranches = self.shopBranches;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (void)toShopList{

    ShopBranchListViewController *vc = [[ShopBranchListViewController alloc] init];
    vc.view.alpha = 1;
    vc.models = [self.shopBranches mutableCopy];
    
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (void)toMap{

    MapViewController *vc = [[MapViewController alloc] init];
    vc.view.alpha = 1;
    vc.shop = self.nearestShopBranch;
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (void)toAfterDownload{
    
    AfterDownloadViewController *vc = [[AfterDownloadViewController alloc] init];
    vc.view.alpha = 1;
    vc.source = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)test{

    L();
//    NSLog(@"coupon id # %@",[[CouponModel couponModel] id]);
}

@end
