//
//  CouponModel.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon

static NSArray *keys;
static NSArray *listKeys;  // 服务器列表返回的dict的key
static NSArray *favoriteKeys; // 用户收藏的快券key
static NSArray *downloadedKeys; // 用户下载的快券key
static NSArray *detailsKeys; // 用户下载的快券key
static NSArray *shortKeys;   // 快券详情其他快券的key

+ (void)initialize {
    if (self == [Coupon self]) {
        // ... do the initialization ...
        
        listKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
        keys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"downloadedCount",@"slogan"];
        favoriteKeys = @[@"title",@"avatarUrl",@"discountContent",@"endDate"];
        downloadedKeys = @[@"title",@"avatarUrl",@"discountContent",@"endDate",@"number"];
        detailsKeys = @[@"id",@"title",@"avatarUrl",@"discountContent",@"endDate",@"downloadedCount",@"message",@"shopCount",@"shopId",@"short_desc",@"startDate",@"usage"];
        shortKeys = @[@"id",@"title",@"discountContent"];

    }
}


- (NSString*)notice{
    
    NSMutableString *notice = [NSMutableString stringWithString:@" *使用时间\n\n"];
    [notice appendFormat:@"%@ 至 %@\n\n\n",self.startDate,self.endDate];
    [notice appendFormat:@"%@\n\n",@" *使用规则"];
    [notice appendFormat:@"%@\n",self.usage];
    return notice;
    
    
}

- (id)initWithDict:(NSDictionary*)dict{
    if (self= [self init]) {
        
        // 把dict的value为null的处理掉
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
//        NSLog(@"couponDict # %@",dict);
        
        NSArray *keys = @[@"title",@"avatarUrl",@"validate",@"discountContent",@"usage",@"maxNumber",@"downloadedCount"];
        
        
        self.id = dict[@"objectId"];
        self.shopId = dict[@"shop"][@"objectId"];
        
        
        for (NSString *key in keys) {
        
            [self setValue:dict[key] forKey:key];
            
        }
        
        if (!ISEMPTY(dict[@"location"])) {

            self.nearestLocation = [[CLLocation alloc]initWithLatitude:[dict[@"location"][@"latitude"] floatValue] longitude:[dict[@"location"][@"longitude"] floatValue]];
        }
        
    }
    

    
    return self;
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
         
         otherCoupons =     (
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/bsk_5.jpg";
         discountContent = "5\U5143\U62b5\U7528\U5238";
         id = 36;
         title = "\U5df4\U65af\U514b";
         },
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/bsk_2.jpg";
         discountContent = "1\U5143\U4eab18\U5143\U6469\U5361";
         id = 37;
         title = "\U5df4\U65af\U514b";
         },
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/bsk_3.jpg";
         discountContent = "\U5168\U573a75\U6298";
         id = 38;
         title = "\U5df4\U65af\U514b";
         }
         );
         
         shopCoupons =     (
         {
         avatarUrl = "http://www.quickquan.com/images/coupons/coupon_id_43.jpg";
         discountContent = "\U7acb\U51cf500\U5143";
         id = 43;
         title = "\U745e\U4e4b\U5802";
         }
         );

         
         */
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

+ (id)couponWithDict:(NSDictionary*)dict{

    return [[Coupon alloc]initWithDict:dict];
}


+ (id)coupon{
    
    Coupon *coup = [Coupon new];
    
    coup.id = @"111";
    
    coup.title = @"[19店通用] 三人行骨头王火锅";
    coup.discountContent = @"95折";
    
    return coup;
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
