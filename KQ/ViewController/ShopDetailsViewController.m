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
//    NSLog(@"shop.poster # %@",shop.posterUrl);
    
    [self.avatarV setImageWithURL:[NSURL URLWithString:shop.posterUrl] placeholderImage:DefaultImg];
    [self.avatarV setContentMode:UIViewContentModeScaleAspectFit];
    self.avatarV.layer.masksToBounds = YES;
    
    self.firstLabel.text = shop.title;
    self.secondLabel.text = shop.desc;
    CGFloat height = [ShopHeaderCell cellHeightWithValue:shop];
    self.secondLabel.frame = CGRectMake(10, 40, 300, height);
}

+ (CGFloat)cellHeightWithValue:(Shop*)shop{
    
    //    NSLog(@"shop # %@",self.va)
    NSString *text = shop.desc;
    UIFont *font = [UIFont fontWithName:kFontName size:12];
    CGSize constraint = CGSizeMake(300, 10000);
    
    CGRect textRect = [text boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    
    return textRect.size.height + 20;
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

    NSLog(@"shopBranches # %@",shopBranches);
    
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

    }
    
    return row;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
//    
//    if (indexPath.section == 0) {
//        height = [ShopHeaderCell cellHeightWithValue:self.shop];
//    }
// 
//    NSLog(@"index # %d,%d, height # %f",indexPath.section,indexPath.row,height);
//    
//    return 100;
//}




- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    
    if([cell isKindOfClass:[ShopHeaderCell class]]){
        
        [cell setValue:self.shop forKeyPath:@"value"];
    }

//    else  if([cell isKindOfClass:[ShopBranchesCell class]]){
//        __weak ShopDetailsViewController *vc = self;
//        ShopBranchesCell *aCell = (ShopBranchesCell*)cell;
//        [(ShopBranchesCell*)cell setValue:[self.shopBranches firstObject]];
//        
//        [(ShopBranchesCell*)cell setShopBranchesNum:[self.shopBranches count]];
//        
//        aCell.toMapBlock = ^(Shop* shop){
//            
//            [vc toMap];
//        };
//        
//        aCell.toShopListBlock = ^{
//            [vc toShopList];
//        };
//        
//    }
}


- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
 
    //after conflict in v0.3 bugfix branch


    
     if([cell isKindOfClass:[CouponListCell class]]){
        CouponListCell *aCell = (CouponListCell*)cell;
        if (!ISEMPTY(self.coupons)) {
            Coupon *coupon = self.coupons[indexPath.row];
            [aCell setValue:coupon];
        }
    }
     else  if([cell isKindOfClass:[ShopBranchesCell class]]){
         __weak ShopDetailsViewController *vc = self;
         ShopBranchesCell *aCell = (ShopBranchesCell*)cell;


         
         //!!!: 如果self.shopBranches是需要asyn载入的，那么就不能放到initConfigCell中，因为只运行一次时可能shopBranches还没载入
         [(ShopBranchesCell*)cell setValue:[self.shopBranches firstObject]];

         [(ShopBranchesCell*)cell setShopBranchesNum:[self.shopBranches count]];
         
         aCell.toMapBlock = ^(Shop* shop){
             
             [vc toMap];
         };
         
         aCell.toShopListBlock = ^{
             [vc toShopList];
         };
         
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
    
    if (!_userController.isLogin) {
        [_libraryManager startHint:@"请先登录快券"];
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
    [_libraryManager startProgress:nil];
    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken favoriteShop:shop.id block:^(id obj, NSError *error) {
        
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
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken unfavoriteShop:shop.id block:^(id obj, NSError *error) {
        
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
