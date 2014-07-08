//
//  CouponDetaisViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponDetailsViewController.h"
#import "Coupon.h"
#import "ShopBranchesCell.h"
#import "ShopModelDescCell.h"
#import "CouponCommentCell.h"
#import "ShopBranchListViewController.h"
#import "Shop.h"
#import "CouponCell.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "ShopDetailsViewController.h"
#import "MapViewController.h"
#import "ImageButtonCell.h"

#pragma mark - CouponHeader
@interface CouponHeaderCell : CouponCell{

   IBOutlet UIButton *_downloadB, *_favoriteB;
    IBOutlet UIImageView *_bgV;
  
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
    
//    L();
    _value = coupon;
    
    
    __weak id cell = self;
    [self.avatarV setImageWithURL:[NSURL URLWithString:coupon.avatarUrl] placeholderImage:DefaultImg success:^(UIImage *image, BOOL cached) {
        Coupon *aCoupon = [(CouponHeaderCell*)cell value];
        [aCoupon setAvatar:image];
    } failure:^(NSError *error) {
        
    }];
    
    self.firstLabel.text = coupon.title;
    self.secondLabel.text = coupon.discountContent;
    self.thirdLabel.text = [NSString stringWithFormat:@"%@人已获取",coupon.downloadedCount];

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
    _bgV.image = [UIImage imageNamed:@"coupon_header_bg.png"];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView removeFromSuperview];

    self.avatarV.layer.cornerRadius = 5;
    self.avatarV.layer.masksToBounds = YES;
}

- (IBAction)downloadPressed:(id)sender{
//    L();
    
    _downloadBlock();
}

- (IBAction)favoriteToggled:(id)sender{
//    L();
    
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

#pragma mark - CouponUsage

@interface CouponUsageCell : CouponCell

@end

@implementation CouponUsageCell

- (void)setValue:(Coupon*)couponModel{
    

    
    _value = couponModel;

    self.firstLabel.text = couponModel.usage;
    

}

- (void)load{
//    L();
    [super load];
    
    self.firstLabel = [[KQLabel alloc] initWithFrame:CGRectMake(10, 0, 300, 100)];
    self.firstLabel.numberOfLines = 0;
    self.firstLabel.font = [UIFont fontWithName:kFontName size:12];
    self.firstLabel.textColor = kColorDardGray;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.firstLabel];
}


@end




#pragma mark - ShopDescCell
@interface ShopDescCell : ConfigCell

@end

@implementation ShopDescCell

- (void)setValue:(Shop*)shop{
    
    _value = shop;

    self.firstLabel.text = shop.desc;
}

// height: 100
- (void)load{
    [super load];
    self.firstLabel = [[KQLabel alloc] initWithFrame:CGRectMake(10, 0, 300, 100)];
    self.firstLabel.numberOfLines = 0;
    self.firstLabel.font = [UIFont fontWithName:kFontName size:12];
    self.firstLabel.textColor = kColorDardGray;
    [self addSubview:self.firstLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (CGFloat)cellHeightWithValue:(Shop*)shop{

//    NSLog(@"shop # %@",self.va)
    
    return 200;
}

@end

#pragma mark - CouponDetailsViewController

@interface CouponDetailsViewController (){
    
}

@end

@implementation CouponDetailsViewController


/**
 
 */

- (void)setCoupon:(Coupon *)coupon{
    
    L();
    _coupon = coupon;
    
    //如果用户已经登录

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
    [[NetworkClient sharedInstance] queryCoupon:coupon.id block:^(NSDictionary *dict, NSError *error) {
   
        dict = [dict dictionaryCheckNull];
        
//        NSLog(@"dict # %@",dict);
     
         if (!ISEMPTY(dict[@"branches"])) {
             NSMutableArray *array = [NSMutableArray array];

            NSArray *branches = dict[@"branches"];
            
            for (NSDictionary *shopDict in branches) {
                
                
                Shop *shop = [Shop shopWithDictionary:shopDict];
                [array addObject:shop];
            }
             
             self.shopBranches = [array copy];
        }
        
//        NSLog(@"branches # %@",self.shopBranches);
        
        self.shop = [Shop shopWithDictionary:dict[@"coupon"][@"shop"]];

        self.nearestShopBranch = [self.shopBranches firstObject];
    
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
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(sharePressed:)];;

    
    
    [self test];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
    
//    [self removeObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#>]
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 3) {
        height = [ShopDescCell cellHeightWithValue:self.shop];
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    
    
    return 40;
}

//- （void)initco

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
    else if([cell isKindOfClass:[CouponUsageCell class]]){
        [(CouponUsageCell*)cell setValue:self.coupon];
    }
    else if([cell isKindOfClass:[ShopDescCell class]]){
        
        //        NSLog(@"shop # %@,desc # %@",self.coupon.shop,self.coupon.shop.desc);
        
        [(ShopDescCell*)cell setValue:self.shop];
    }
    else if([cell isKindOfClass:[ConfigCell class]]){
        
        cell.imageView.image = [UIImage imageNamed:@"icon_myfavoritedshops.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    

}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    if([cell isKindOfClass:[ShopBranchesCell class]]){
        
      
        [(ShopBranchesCell*)cell setValue:[self.shopBranches firstObject]];
        
        [(ShopBranchesCell*)cell setShopBranchesNum:[self.shopBranches count]];
 
        
    }
    else if([cell isKindOfClass:[CouponHeaderCell class]]){
        
    
        [(CouponHeaderCell*)cell setHasFavoritedCoupon:self.isFavoritedCoupon];
      
    }
    
}


#pragma mark - IBAction


- (IBAction)backPressed:(id)sender{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)sharePressed:(id)sender{
    
    [self shareCoupon:self.coupon];

    
}


#pragma mark - Fcns

- (void)downloadCoupon:(Coupon*)coupon{

//    NSLog(@"coupon # %@",coupon);
    
     [_libraryManager startProgress:nil];
    
    [_networkClient user:_userController.uid downloadCoupon:coupon.id block:^(id obj, NSError *error) {

        [_libraryManager dismissProgress:nil];
        
        if (obj) {
//          NSLog(@"did download");
            
            [_libraryManager startHint:@"下载快券成功"];
        }
        
    }];
    
}

- (void)toggleFavoriteCoupon:(Coupon*)coupon{
    
    if (self.isFavoritedCoupon) {
        [self unfavoriteCoupon:coupon];
    }
    else{
        [self favoriteCoupon:coupon];
    }
}
- (void)favoriteCoupon:(Coupon*)coupon{

    [_libraryManager startProgress:nil];
    
    [_networkClient user:_userController.uid favoriteCoupon:coupon.id block:^(id obj, NSError *error) {

            [_libraryManager dismissProgress:nil];
        
        if (obj) {
            [_libraryManager startHint:@"收藏成功"];

            self.isFavoritedCoupon = YES;
            
 
            [_userController.people.favoritedCouponIds addObject:coupon.id];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedCoupons" object:nil];
        }
    }];
}
- (void)unfavoriteCoupon:(Coupon*)coupon{
    
    [_libraryManager startProgress:nil];
    [_networkClient user:_userController.uid unfavoriteCoupon:coupon.id block:^(id obj, NSError *error) {
        
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

- (void)toShop{

//    if (!_shopDetailsVC) {
//        _shopDetailsVC = [[ShopDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    }
    
//    _shopDetailsVC.shop = 

    [self performSegueWithIdentifier:@"toShop" sender:nil];
}

- (void)toShopList{


    [self performSegueWithIdentifier:@"toShopBranch" sender:nil];
}

- (void)toMap{

    [self performSegueWithIdentifier:@"toMap" sender:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSString *identifier = segue.identifier;
    
    if ([segue.identifier isEqualToString:@"toShop"])
    {
        //        L();
    
        [segue.destinationViewController setValue:self.shop forKeyPath:@"shop"];
        [segue.destinationViewController setValue:self.shopBranches forKeyPath:@"shopBranches"];

        
    }
    else if([identifier isEqualToString:@"toShopBranch"]){
    
        //set models
//        NSLog(@"shopBranches # %@",self.shopBranches);
        
        [segue.destinationViewController setValue:self.shopBranches forKeyPath:@"models"];
        
    }
    else if([identifier isEqualToString:@"toMap"]){
    
        [segue.destinationViewController setValue:self.nearestShopBranch forKeyPath:@"shop"];
        
    }
}


- (void)test{

    L();
//    NSLog(@"coupon id # %@",[[CouponModel couponModel] id]);
}

@end
