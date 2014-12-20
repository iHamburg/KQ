//
//  CouponDetaisViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CouponDetailsViewController.h"

#import "ShopBranchesCell.h"

#import "AutoHeightCell.h"
#import "AutoHeight2Cell.h"

#import "UMSocial.h"
#import "UIImageView+WebCache.h"

#import "AddCardViewController.h"
#import "ShopBranchListViewController.h"
#import "ShopDetailsViewController.h"
#import "MapViewController.h"
#import "AfterDownloadViewController.h"
#import "DownloadAddCardViewController.h"
#import "UserCouponsViewController.h"

#pragma mark - Cell: CouponHeader

@interface CouponHeaderCell : ConfigCell{

    IBOutlet UIButton *_downloadB, *_favoriteB;
    IBOutlet UILabel *_downloadNumL;
  
}

@property (nonatomic, strong) UIButton *favoriteB;
@property (nonatomic, assign) BOOL hasFavoritedCoupon;
@property (nonatomic, copy) VoidBlock downloadBlock;
@property (nonatomic, copy) void (^downloadBlock2)(UIView*);
@property (nonatomic, copy) VoidBlock toggleFavoriteBlock;

- (IBAction)downloadPressed:(id)sender;
- (IBAction)favoriteToggled:(id)sender;


@end


@implementation CouponHeaderCell

// 180: 135 + 45

- (void)setValue:(Coupon*)coupon{
    

    _value = coupon;
    
    
    __weak id cell = self;
    
    
//    NSLog(@"coupon # %@,avatar # %@",coupon,coupon.avatarUrl);
    
    [self.avatarV setImageWithURL:[NSURL URLWithString:coupon.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(UIImage *image, BOOL cached) {
    
        Coupon *aCoupon = [(CouponHeaderCell*)cell value];
        [aCoupon setAvatar:image];
        
    } failure:^(NSError *error) {}];

    self.firstLabel.text = ISEMPTY(coupon.discountContent)?@"":coupon.discountContent;
    self.secondLabel.text = ISEMPTY(coupon.title)?@"":coupon.title;

    self.thirdLabel.text = ISEMPTY(coupon.short_desc)?@"": coupon.short_desc;
    self.thirdLabel.numberOfLines = 0;
    
    
    NSString *downloaded = coupon.downloadedCount;
    if (ISEMPTY(downloaded)) {
        downloaded = @"0";
    }
    _downloadNumL.text = [NSString stringWithFormat:@"%@人已下载",downloaded];

    ///如果sellout
    if (coupon.sellOut) {
    
        _downloadB.backgroundColor = kColorGray;
        _downloadB.userInteractionEnabled = NO;
        [_downloadB setTitle:@"已抢光" forState:UIControlStateNormal];
    
    }
    else{
        
        _downloadB.backgroundColor = kColorRed;
        _downloadB.userInteractionEnabled = YES;
        [_downloadB setTitle:@"下载快券" forState:UIControlStateNormal];
    
    }

}



- (void)load{

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [[NSNotificationCenter defaultCenter] addObserverForName:@"refreshFavoritedCoupons" object:nil queue:nil usingBlock:^(NSNotification *note) {
        BOOL isFavorited = [note.object boolValue];
        
        __weak CouponHeaderCell *cell = self;
        
        if (isFavorited) {
           [cell.favoriteB setBackgroundImage:[UIImage imageNamed:@"coupon_favorited.png"] forState:UIControlStateNormal];
        }
        else{
            [cell.favoriteB setBackgroundImage:[UIImage imageNamed:@"coupon_unfavorited.png"] forState:UIControlStateNormal];
        }
    }];


    [self.contentView removeFromSuperview];

    _firstLabel.textColor = kColorRed;
    _firstLabel.font = bFont(16);
    
    _secondLabel.textColor = kColorBlack;
    _secondLabel.font = [UIFont fontWithName:kFontName size:16];
    _thirdLabel.textColor = kColorBlack;
    _thirdLabel.font = bFont(11);
    
    _downloadNumL.textColor = kColorBlack;
    _downloadNumL.font = [UIFont fontWithName:kFontName size:11];
    
    _downloadB.backgroundColor = kColorRed;
    _downloadB.layer.cornerRadius = 3;
    
    [_favoriteB setBackgroundImage:[UIImage imageNamed:@"coupon_unfavorited.png"] forState:UIControlStateNormal];
 
    //分割线
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 246, _w, 1)];
    v.backgroundColor = kColorLightGray;
    [self addSubview:v];
    
    // 虚线分割线
    UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 336, _w, 1)];
    separatorV.image = [UIImage imageNamed:@"bg_虚线.png"];
    [self addSubview:separatorV];
    
    //垂直分割线
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(250, 342, 1, 22)];
    v2.backgroundColor = kColorLightGray;
    [self addSubview:v2];
    
//    self.favoriteB.backgroundColor = kColorBlack;
}



- (IBAction)downloadPressed:(id)sender{
    
//    self.downloadBlock();
    self.downloadBlock2(_downloadB);
}

- (IBAction)favoriteToggled:(id)sender{
    
    _toggleFavoriteBlock();

}

- (void)dealloc{
//    L();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

#pragma mark - CouponShortCell

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
    self.textLabel.font = bFont(15);
    self.textLabel.textColor = kColorYellow;
    
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 165, 45)];
    _firstLabel.font = bFont(15);
    _firstLabel.textColor  = kColorBlack;
    
    [self addSubview:self.firstLabel];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self addBottomLine:kColorLightGray];
    
}

- (void)layoutSubviews{
    
}

- (void)dealloc{
//    L();
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
   
//    __weak CouponDetailsViewController *vc = self;
    [_networkClient queryCoupon:coupon.id latitude:_userController.latitude longitude:_userController.longitude block:^(NSDictionary *dict, NSError *error) {
   
        
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
     
        
//        NSLog(@"oldNum # %@, downloadCount # %@",vc.oldDNum,_coupon.downloadedCount);

        [self.tableView reloadData];
   
    
    }];
    
    //如果用户已经登录, 查看coupon是否已经收藏
    if ([_userController isLogin]) {
        ///判断coupon是否已经收藏
        
        [_networkClient queryIfFavoritedCouupon:_userController.uid couponId:coupon.id block:^(NSDictionary *dict, NSError *error) {
            
            if (error) {
                return ;
            }
            
            self.isFavoritedCoupon = [dict[@"result"] boolValue];
        }];
    }

}

- (void)setIsFavoritedCoupon:(BOOL)isFavoritedCoupon{
    _isFavoritedCoupon = isFavoritedCoupon;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFavoritedCoupons" object:[NSString stringWithInt:isFavoritedCoupon]];

}

#pragma mark - Init

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.config = [[TableConfiguration alloc] initWithResource:@"CouponDetailsConfig"];

    self.title = @"快券详情";
    
    
    UIBarButtonItem *shareBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"titlebar_share_btn.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sharePressed:)];
    
    self.navigationItem.rightBarButtonItem = shareBB;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
     [MobClick beginLogPageView:@"CouponDetails"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    L();
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        height = [AutoHeightCell cellHeightWithString:self.coupon.notice font:[UIFont fontWithName:kFontName size:12]] ;
        
        
    }

    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    if (section == 0) {
        return 1;
    }
    
    if (section == 5 && ISEMPTY(_coupon.shopCoupons) ) {
        return 1;
    }
    
    return 40;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = [super tableView:tableView titleForHeaderInSection:section];
    
//    NSLog(@"header # %@",header);
    
    if (section == 5 && ISEMPTY(_coupon.shopCoupons) ) {
        header = nil;
    }
    
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [super tableView:tableView viewForHeaderInSection:section];
    
    if (section == 5 && ISEMPTY(_coupon.shopCoupons) ) {
        return nil;
    }
    
    return view;
    
}

- (void)initConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    __weak CouponDetailsViewController *vc = self;
    
    
    if([cell isKindOfClass:[ShopBranchesCell class]]){
        
        ShopBranchesCell *aCell = (ShopBranchesCell*)cell;
        
        
        aCell.toShopBlock = ^{
            [vc pushShop];
        };
        
        aCell.toShopListBlock = ^{
            [vc pushShopList];
        };
        
    }
    else if([cell isKindOfClass:[CouponHeaderCell class]]){
        
        CouponHeaderCell *aCell = (CouponHeaderCell*)cell;
        
        aCell.downloadBlock2 = ^(UIView* sender){
            
            if(![[UserController sharedInstance] isLogin]){
                [vc willDownloadCoupon:vc.coupon sender:sender];
            }
            else{
                [vc downloadCoupon:vc.coupon sender:sender];
            }
        };
        
        aCell.toggleFavoriteBlock = ^{
        
            [vc toggleFavoriteCoupon:vc.coupon];
        
        };
       
    }
   

}

- (void)configCell:(ConfigCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    int row = indexPath.row;
    
    if([cell isKindOfClass:[CouponHeaderCell class]]){
        
        [(CouponHeaderCell*)cell setValue:self.coupon];
        
        [(CouponHeaderCell*)cell setHasFavoritedCoupon:self.isFavoritedCoupon];
        
    }
    else if([cell isKindOfClass:[ShopBranchesCell class]]){
        
      
        [(ShopBranchesCell*)cell setValue:self.coupon.nearestShopBranch];
        
        [(ShopBranchesCell*)cell setShopBranchesNum:[_coupon.shopCount intValue]];
 
        
    }
    else if([cell isKindOfClass:[AutoHeightCell class]]){
        NSString *key = cell.key;
        [cell setValue:[self.coupon valueForKey:key]];

    }

    if ([cell.key isEqualToString:@"shopCoupons"]) {
        if (ISEMPTY(self.coupon.shopCoupons)) {
            return;
        }
        Coupon *coupon = self.coupon.shopCoupons[row];
        [cell setValue:coupon];

    }
    else if([cell.key isEqualToString:@"otherCoupons"]){
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

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    L();
    
    if (buttonIndex == 1) {
        [self pushMyCoupons];
    }
}

//- (void)willPresentAlertView:(UIAlertView *)alertView{
//    NSLog(@"alert.subview # %@",alertView.subviews);
//}

#pragma mark - IBAction



- (IBAction)sharePressed:(id)sender{
    
    [self shareCoupon:self.coupon];

    
}


#pragma mark - Fcns

//没有登录的用户先present登录流程，如果成功的话
- (void)willDownloadCoupon:(Coupon*)coupon sender:(id)sender{
    __weak CouponDetailsViewController *vc = self;

    [_root presentLoginWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {// 登录或注册成功，自动更新用户信息
            NSLog(@"login successful, to download");

            [vc downloadCoupon:coupon sender:sender];
        }
    }];


}

- (void)downloadCoupon:(Coupon*)coupon sender:(id)sender{
 
//    [self pushAfterDownload];
//    return;
    
    //    NSLog(@"coupon # %@",coupon);
    __weak CouponDetailsViewController *vc = self;

    
    [self willLoad:sender];
    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken downloadCoupon:coupon.id block:^(id obj, NSError *error) {
        
        [vc willStopLoad];
        
        
        if (!vc.networkFlag) {
            return ;
        }

        //如果出错
        if (error) {
            
            if (error.code == ErrorUnionNoCardBunden) { // 已经绑定银联用户，但是删除了所有的银行卡
            
                [self presentAddCard];
                
            }
            else if(error.code == ErrorDownloadCouponLimit || error.code == ErrorDownloadEventCouponLimit){ // 如果用户下载过优惠券或是活动券
            
//                _alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"我的快券", nil];
                _alert = [[UIAlertView alloc] initWithTitle:@"" message:error.localizedDescription delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"我的快券", nil];

                [_alert show];
            }
            else{
                [ErrorManager alertError:error];
            
            }
            
            return;
        }
 
//       下载成功后到afterdownload去, 新注册肯定没有卡， 登录和忘记密码有可能有卡
        [vc pushAfterDownload];
    }];
    
}


- (void)toggleFavoriteCoupon:(Coupon*)coupon{

    if (!_userController.isLogin) {
       
        [_root presentLoginWithBlock:^(BOOL succeeded, NSError *error) {
            
        }];
        
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

//    __weak CouponDetailsViewController *vc = self;

    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken favoriteCoupon:coupon.id block:^(id obj, NSError *error) {


        if (error) {
            [ErrorManager alertError:error];
            return ;
        }
        
        [_libraryManager startHint:@"收藏成功"];

        self.isFavoritedCoupon = YES;
       
        
    }];
    
}
- (void)unfavoriteCoupon:(Coupon*)coupon{
    
    [_networkClient user:_userController.uid sessionToken:_userController.sessionToken unfavoriteCoupon:coupon.id block:^(id obj, NSError *error) {
        
        if (error) {
            [ErrorManager alertError:error];
            return ;
        }

        [_libraryManager startHint:@"取消收藏"];
        
        self.isFavoritedCoupon = NO;
        

    }];
}

- (void)shareCoupon:(Coupon*)coupon{
    
    //如果没有coupon
    if (!coupon) {
        return;
    }
    
    
    [_libraryManager shareCoupon:coupon delegate:self];
}

- (void)pushCoupon:(Coupon*)coupon{
    
    CouponDetailsViewController *vc = [[CouponDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = coupon;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushShop{

    ShopDetailsViewController *vc = [[ShopDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1.0;
    vc.shop = self.coupon.nearestShopBranch;

    
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (void)pushShopList{

    ShopBranchListViewController *vc = [[ShopBranchListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.headerShopId = _coupon.shopId; // 把总店的id传过去

    
    [self.navigationController pushViewController:vc animated:YES];
    

}

// 下载完成
- (void)pushAfterDownload{

    AfterDownloadViewController *vc = [[AfterDownloadViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.coupon = self.coupon;
    vc.vc = self;
    
    [self.navigationController pushViewController:vc animated:YES];


}

- (void)pushMyCoupons{
    UserCouponsViewController *vc = [[UserCouponsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentAddCard{
    
    DownloadAddCardViewController *vc = [[DownloadAddCardViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.view.alpha = 1;
    vc.presentBlock = ^(BOOL succeeded, NSError *error){
//        L();
        [self downloadCoupon:_coupon sender:nil];
    };
    
    [_root presentNav:vc ];
    
}

- (void)showDownloadGuide{
    
    
    if (!_downloadGuideV) {
        _downloadGuideV = [[DownloadGuideView alloc] initWithFrame:self.navigationController.view.bounds];
        _downloadGuideV.imgNames = @[@"guide02-step03.jpg",@"guide02-step04.jpg"];
        
        
    }
    __weak CouponDetailsViewController *vc = self;
    _downloadGuideV.pageClickedBlock = ^(int index){ // banner的新手教程要进入couponlist！
//        L();
        
        
        [vc.downloadGuideV removeFromSuperview];

        [vc pushShopList];
        
    };
    
    _downloadGuideV.backBlock = ^{
        
        [vc.downloadGuideV removeFromSuperview];

        
    };
    
    [_downloadGuideV reset];
    [self.navigationController.view addSubview:_downloadGuideV];
    
}

- (void)test{

    L();
//    NSLog(@"coupon id # %@",[[CouponModel couponModel] id]);
}

@end
