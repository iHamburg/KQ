//
//  CouponModel.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Coupon.h"
#import "Shop.h"

@implementation Coupon

static NSArray *keys;      // 显示用
static NSArray *listKeys;  // Main列表返回的dict的key
static NSArray *favoriteKeys; // 用户收藏的快券key
static NSArray *downloadedKeys; // 用户下载的快券key
static NSArray *detailsKeys; // 快券详情的快券key
static NSArray *shortKeys;   // 快券详情其他快券的key
static NSArray *shopDetaisKeys;   // 商户详情中快券的key
static NSArray *searchKeys;

+ (void)initialize {
    if (self == [Coupon self]) {
        // ... do the initialization ...
       
         keys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
        
        listKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
       
        favoriteKeys = @[@"title",@"avatarUrl",@"discountContent",@"endDate"];
        downloadedKeys = @[@"title",@"avatarUrl",@"discountContent",@"endDate",@"number"];
        detailsKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"endDate",@"downloadedCount",@"message",@"shopCount",@"shopId",@"short_desc",@"startDate",@"usage",@"slogan"];
        shortKeys = @[@"id",@"title",@"discountContent"];
        
        /*
         avatarUrl = "http://www.quickquan.com/images/coupons/coupon_id_39_new.jpg";
         discountContent = "\U7279\U4ef71\U5143";
         downloadedCount = 14;
         id = 39;
         isEvent = 1;
         isSellOut = 0;
         slogan = "\U301018\U5e97\U901a\U7528\U301118\U5143\U7f8e\U5473\U6469\U63d0\U5957\U9910";
         title = "\U6469\U63d0\U5de5\U623f";
         
         */
        shopDetaisKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];

        searchKeys = @[@"id",@"shopbranchTitle",@"avatarUrl",@"discountContent",@"downloadedCount",@"distance"];
    }
}


- (NSString*)notice{
    
    NSMutableString *notice = [NSMutableString stringWithString:@"使用时间\n\n"];
    [notice appendFormat:@"%@ 至 %@\n\n\n",self.startDate,self.endDate];
    [notice appendFormat:@"%@\n\n",@"使用规则"];
    [notice appendFormat:@"%@\n",self.usage];
    return notice;
    
}

- (NSString *)avatarThumbUrl{
    

    NSString *fileName = [self.avatarUrl stringByDeletingPathExtension];
    NSString *extension = [self.avatarUrl pathExtension];

    
//    NSLog(@"filename # %@, extension # %@",fileName,extension);
    NSString *thumb = [NSString stringWithFormat:@"%@_thumb.%@",fileName,extension];
    
    return thumb;
}

+ (id)eventCoupon{
    Coupon *coupon = [[Coupon alloc] init];
    coupon.id = @"39";
    return coupon;
}

- (id)initWithListDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }

        for (NSString *key in listKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
    }
    
    return self;
}

- (id)initWithFavoriteDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in favoriteKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.id = dict[@"couponId"];
        self.active = [dict[@"active"] boolValue];
    }
    
    return self;
}

- (id)initWithDownloadedDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in downloadedKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
        self.id = dict[@"couponId"];
        self.active = [dict[@"active"] boolValue];
    }
    
    return self;

}

- (id)initWithDetailsDict:(NSDictionary *)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in detailsKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
       
        self.active = [dict[@"active"] boolValue];
        self.sellOut = [dict[@"isSellOut"] boolValue];
        self.desc = dict[@"description"];
        /*
         nearestShop =     {
         active = 1;
         address = "\U4ed9\U971e\U897f\U8def88\U53f7\U767e\U8054\U897f\U90ca\U8d2d\U7269\U4e2d\U5fc34213\U5ba4";
         averagePreis = 2044;
         bank = "\U4ea4\U884c";
         distance = "40.24032881220776";
         districtId = 14;
         id = 256;
         latitude = "31.214329";
         logoUrl = "http://www.quickquan.com/images/merchant/rzt_5.jpg";
         longitude = "121.376038";
         mchntId = 301310059778521;
         openTime = "10:00-21:30";
         phone = "021-52199229";
         phone2 = "";
         shopId = 35;
         terminalId = 37082012;
         title = "\U745e\U4e4b\U5802\U5973\U6027\U5065\U5eb7\U8c03\U7406(\U767e\U8054\U897f\U90ca\U4e2d\U5fc3\U5e97)";
         };
         
              
         */
        
        _nearestShopBranch = [[Shop alloc] initWithCouponDetailsDict:dict[@"nearestShop"]];
        
        NSArray *shopCoupons = dict[@"shopCoupons"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in shopCoupons) {
            Coupon *coupon = [[Coupon alloc] initWithShortDict:dict];
            [array addObject:coupon];
        }
        _shopCoupons = [array copy];
        
        NSArray *otherCoupons = dict[@"otherCoupons"];
        array = [NSMutableArray array];
        for (NSDictionary *dict in otherCoupons) {
            Coupon *coupon = [[Coupon alloc] initWithShortDict:dict];
            [array addObject:coupon];
        }
        _otherCoupons = [array copy];
        
        
    }
    
    return self;

}

- (id)initWithShortDict:(NSDictionary *)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in shortKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
    }
    
    return self;
}

- (id)initWithShopDetailsDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in shopDetaisKeys) {
            [self setValue:dict[key] forKey:key];
        }
        
    }
    
    return self;
}

- (id)initWithSearchDict:(NSDictionary*)dict{
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        for (NSString *key in searchKeys) {
       
            
            [self setValue:dict[key] forKey:key];
        
        
        }
        
         self.nearestLocation = [[CLLocation alloc]initWithLatitude:[dict[@"latitude"] floatValue] longitude:[dict[@"longitude"] floatValue]];
        
    }
    
    return self;
}
- (void)display{
    
    NSArray *keys = @[@"id",@"shopId",@"title",@"avatarUrl",@"validate",@"discountContent",@"usage",@"maxNumber",@"downloadedCount"];
    
    NSLog(@"--------------Begin Display Coupon # %@------------\n",self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    NSLog(@"--------------End Display----------------");
}

@end
