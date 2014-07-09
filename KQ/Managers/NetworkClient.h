//
//  NetworkClient.h
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG
//#define HOST @"http://localhost/kq/index.php/kqavos"
//#define RESTHOST @"http://localhost/kq/index.php/kqapi"

#define HOST @"http://192.168.1.100/kq/index.php/kqavos"
#define RESTHOST @"http://192.168.1.100/kq/index.php/kqapi2"
#define MYHOST @"http://192.168.1.100/kq/index.php/kqmyapi2"

#else

#define HOST @"http://115.29.148.47/kq/index.php/kqavos"
#define RESTHOST @"http://115.29.148.47/kq/index.php/kqapi2"
#define MYHOST @"http://115.29.148.47/kq/index.php/kqmyapi2"

#endif



@interface NetworkClient : NSObject{
    AFHTTPRequestOperationManager *_clientManager;
}


+ (id)sharedInstance;






/**
 *	@brief 获取用户个人信息
 *
 */
- (void)queryUser:(NSString*)uid block:(IdResultBlock)block;

/**
 *	@brief 获取优惠券信息
 */

- (void)queryCoupon:(NSString*)couponId block:(IdResultBlock)block;




/**
 *	@brief	用户注册登录
 */

- (void)registerWithDict:(NSDictionary*)info block:(IdResultBlock)block;
- (void)loginWithUsername:(NSString*)username password:(NSString*)password block:(IdResultBlock)block;


/**
 *	@brief	获取用户收藏的商户
 */
- (void)queryShopBranches:(NSString*)parentId block:(IdResultBlock)block;



- (void)queryHotCouponsSkip:(int)skip block:(IdResultBlock)block;
- (void)queryCouponsWithShop:(NSString*)shopId block:(IdResultBlock)block;


- (void)queryCouponTypesWithBlock:(IdResultBlock)block;

/**
 *	@brief	获取所有一级商区
 */
//- (void)queryDistrictsWithBlock:(IdResultBlock)block;

- (void)queryHeadDistrictsWithBlock:(IdResultBlock)block;



/**
 *	@brief	获取所有一级快券类型
 *
 */
- (void)queryHeadCouponTypesWithBlock:(IdResultBlock)block;


/**
 *	@brief	获取用户的银行卡
 */
- (void)queryCards:(NSString*)uid block:(IdResultBlock)block;

- (void)user:(NSString*)uid addCard:(NSString*)cardNumber block:(IdResultBlock)block;

/**
 *	@brief	获取用户下载的优惠券
 */
- (void)queryDownloadedCoupon:(NSString*)uid block:(IdResultBlock)block;
- (void)user:(NSString*)uid downloadCoupon:(NSString*)couponId block:(IdResultBlock)block;
/**
 *	@brief	获取用户收藏的优惠券
 */
- (void)queryFavoritedCoupon:(NSString*)uid block:(IdResultBlock)block;
- (void)user:(NSString*)uid favoriteCoupon:(NSString*)couponId block:(IdResultBlock)block;
- (void)user:(NSString*)uid unfavoriteCoupon:(NSString*)couponId block:(IdResultBlock)block;

/**
 *	@brief	获取用户收藏的商户
 */
- (void)queryFavoritedShop:(NSString*)uid block:(IdResultBlock)block;
- (void)user:(NSString*)uid favoriteShop:(NSString*)shopId block:(IdResultBlock)block;
- (void)user:(NSString*)uid unfavoriteShop:(NSString*)shopId block:(IdResultBlock)block;


- (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;

- (void)test;

@end
