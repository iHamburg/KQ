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

#pragma mark - ShopHeaderCell

@interface ShopHeaderCell : ConfigCell

@end

@implementation ShopHeaderCell

- (void)setValue:(Shop*)shop{

    _value = shop;
    
//    NSLog(@"imageUrl # %@",shop.posterUrl);
    
    [self.avatarV setImageWithURL:[NSURL URLWithString:shop.posterUrl] placeholderImage:DefaultImg];
    self.firstLabel.text = shop.title;
    self.secondLabel.text = shop.desc;
}

@end

#pragma mark - ShopDetailsViewController

@interface ShopDetailsViewController (){
    UIBarButtonItem *_favoritedBB, *_unfavoritedBB;
}

@property (nonatomic, strong) NSMutableArray *coupons;
@end

@implementation ShopDetailsViewController

- (void)setShop:(Shop *)shop{
    _shop = shop;
 
    ///判断coupon是否已经收藏
    self.shopFavorited = NO;
    for (NSString *shopId in [[UserController sharedInstance]people].favoritedShopIds) {
//        NSLog(@"shopId # %@,shop.id # %@",shopId,shop.id);
        
        if ([shopId isEqualToString:shop.id]) {

            self.shopFavorited = YES;
            break;
        }
    }
    

    
    [[NetworkClient sharedInstance] queryCouponsWithShop:shop.id block:^(NSArray *coupons, NSError *error) {
        
//        NSLog(@"coupons # %@",coupons);
        
        self.coupons = [NSMutableArray array];
        
        for (NSDictionary *couponDict in coupons) {
            Coupon *coupon = [Coupon couponWithDict:couponDict];
            [self.coupons addObject:coupon];
        }
        
        [self.tableView reloadData];
    }];
}

- (void)setShopFavorited:(BOOL)isShopFavorited{
    _shopFavorited = isShopFavorited;
    
    
  
    if (isShopFavorited) {
        self.navigationItem.rightBarButtonItem = _unfavoritedBB;
       
    }
    else{
        self.navigationItem.rightBarButtonItem = _favoritedBB;
       
    }
}


- (void)setShopBranches:(NSArray *)shopBranches{

    _shopBranches = shopBranches;

//    NSLog(@"shopBranches # %@",shopBranches);
    
    [self.tableView reloadData];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        _favoritedBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_emptyStar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(favoritePressed:)];
        
        
        _unfavoritedBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_fullStar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(favoritePressed:)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.config = [[TableConfiguration alloc] initWithResource:@"ShopConfig"];

    self.title = self.shop.title;
    
//    _favoritedBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_emptyStar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(favoritePressed:)];
//    
//    
//    _unfavoritedBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_fullStar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(favoritePressed:)];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)favoritePressed:(id)sender{
    L();
    [self toggleFavoriteShop:self.shop];
}
#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int row = [super tableView:tableView numberOfRowsInSection:section];
    
    if (section == 2) {
        row = self.coupons.count;
//        L();
//        NSLog(@"coupoons # %@",self.coupons);
    }
    
    return row;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    

    if([cell isKindOfClass:[ShopHeaderCell class]]){
      
        [cell setValue:self.shop forKeyPath:@"value"];
    }
    else  if([cell isKindOfClass:[ShopBranchesCell class]]){
        __weak ShopDetailsViewController *vc = self;
        ShopBranchesCell *aCell = (ShopBranchesCell*)cell;
        [(ShopBranchesCell*)cell setValue:[self.shopBranches firstObject]];
        
        [(ShopBranchesCell*)cell setShopBranchesNum:[self.shopBranches count]];
        
        aCell.toMapBlock = ^(Shop* shop){
            
            [vc toMap];
        };
        
        aCell.toShopListBlock = ^{
            [vc toShopList];
        };

    }
    else if([cell isKindOfClass:[CouponListCell class]]){
        CouponListCell *aCell = (CouponListCell*)cell;
        if (!ISEMPTY(self.coupons)) {
            Coupon *coupon = self.coupons[indexPath.row];
            [aCell setValue:coupon];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        // coupon
        
        Coupon *coupon = self.coupons[indexPath.row];
        [self toCouponDetails:coupon];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fcns


- (void)toggleFavoriteShop:(Shop*)shop{
    
    if (self.shopFavorited) {
        [self unfavoriteShop:shop];
    }
    else{
        [self favoriteShop:shop];
    }
}
- (void)favoriteShop:(Shop*)shop{
    [_libraryManager startProgress:nil];
    
    [_networkClient user:_userController.uid favoriteShop:shop.id block:^(id obj, NSError *error) {
        
        [_libraryManager dismissProgress:nil];
        
     
        if (obj) {
            [_libraryManager startHint:@"收藏成功"];
            self.shopFavorited = YES;
            
            [_userController.people.favoritedShopIds addObject:shop.id];
            
            ///给UserShopVC
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedShops" object:nil];
        }
    }];

}
- (void)unfavoriteShop:(Shop*)shop{
    [_libraryManager startProgress:nil];
    [_networkClient user:_userController.uid unfavoriteShop:shop.id block:^(id obj, NSError *error) {
        
        [_libraryManager dismissProgress:nil];
        
        //        NSLog(@"did unfavorite");
        if (obj) {
             [_libraryManager startHint:@"取消收藏"];
            self.shopFavorited = NO;
            [_userController.people.favoritedShopIds removeObject:shop.id];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedShops" object:nil];
        }
        
    }];
}

- (void)toShopList{
    
    
    [self performSegueWithIdentifier:@"toShopBranch" sender:nil];
}

- (void)toMap{
    
    [self performSegueWithIdentifier:@"toMap" sender:nil];
}

- (void)toCouponDetails:(id)coupon{
    [self performSegueWithIdentifier:@"toCouponDetails" sender:coupon];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSString *identifier = segue.identifier;
    
   if([identifier isEqualToString:@"toShopBranch"]){
        
        //set models
        //        NSLog(@"shopBranches # %@",self.shopBranches);
        
        [segue.destinationViewController setValue:self.shopBranches forKeyPath:@"models"];
        
    }
   else if([identifier isEqualToString:@"toMap"]){
       
       [segue.destinationViewController setValue:[self.shopBranches firstObject] forKeyPath:@"shop"];
       
   }
   else if([identifier isEqualToString:@"toCouponDetails"]){
       
       [segue.destinationViewController setValue:sender forKeyPath:@"coupon"];
       
   }
    
}


@end
