//
//  AVOSServer.m
//  KQ
//
//  Created by AppDevelopper on 14-6-9.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AVOSServer.h"

@implementation AVOSServer

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc] init];
    });
    
    return sharedInstance;
}

- (void)initUser{

    NSString *dictPath = [NSString filePathForResource:@"db.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *users = dict[@"user"];

    NSLog(@"users # %@",users);
    
    for (NSDictionary *userDict in users) {
        AVUser * user = [AVUser user];
        user.username = userDict[@"username"];
        user.password = userDict[@"password"];
        [user setObject:userDict[@"phone"] forKey:@"phone"];
        [user signUpInBackground];
//        user.email = @"steve@company.com";
    }

}

- (void)initDistrict{
    NSString *dictPath = [NSString filePathForResource:@"db.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = dict[@"district"];
    
//    NSLog(@"district # %@",array);
    
    for (NSDictionary *aDict in array) {
        AVObject *obj = [AVObject objectWithClassName:@"District"];
        [obj setObject:aDict[@"title"] forKey:@"title"];
        
       
        [obj saveInBackground];

    }
}

- (void)initShops{
    NSString *dictPath = [NSString filePathForResource:@"db.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = dict[@"shops"];
    
    
    for (NSDictionary *aDict in array) {
        AVObject *avObj = [AVObject objectWithClassName:@"Shop"];
        NSArray *keys = @[@"title",@"desc",@"posterUrl",@"phone",@"address",@"openTime"];

        for (NSString *key in keys) {
            id obj = aDict[key];
            if (!ISEMPTY(obj)) {
                [avObj setObject:obj forKey:key];
            }
        }
        [avObj saveInBackground];
        
    }

}

- (void)initCoupons{
    NSString *dictPath = [NSString filePathForResource:@"db.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = dict[@"coupons"];
    for (NSDictionary *aDict in array) {
        AVObject *avObj = [AVObject objectWithClassName:@"Coupon"];
        NSArray *keys = @[@"title",@"avatarUrl",@"validate",@"discountContent",@"usage",@"maxNumber"];
        
        for (NSString *key in keys) {
            id obj = aDict[key];
            if (!ISEMPTY(obj)) {
                [avObj setObject:obj forKey:key];
            }
        }
        [avObj saveInBackground];
        
    }

}

- (void)initCouponTypes{
    NSString *dictPath = [NSString filePathForResource:@"db.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSArray *array = dict[@"couponTypes"];
    for (NSString *type in array) {
        AVObject *avObj = [AVObject objectWithClassName:@"CouponType"];

         [avObj setObject:type forKey:@"title"];
        [avObj saveInBackground];
        
    }

}

- (void)test{

    
    L();
    
    
//    [self initCouponTypes];
    
//    [self initCoupons];
    
//    [self initShops];
//    [self addUser];
 //   [self initDistrict];
}

@end
