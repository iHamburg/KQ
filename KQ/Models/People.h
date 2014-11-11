//
//  People.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject<NSCoding>

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;  // md5
@property (nonatomic, copy) NSString *sessionToken;

@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) int cardNum;
@property (nonatomic, assign) int dCouponNum;
@property (nonatomic, assign) int fCouponNum;
@property (nonatomic, assign) int fShopNum;

@property (nonatomic, strong) NSMutableSet *favoritedCouponIds;
@property (nonatomic, strong) NSMutableSet *favoritedShopIds;
@property (nonatomic, strong) NSMutableSet *cardIds; //set
@property (nonatomic, strong) NSMutableSet *downloadedCouponIds; //set


+ (id)people;

+ (id)peopleWithDict:(NSDictionary*)dict;

- (id)initWithDict:(NSDictionary*)dict;


@end
