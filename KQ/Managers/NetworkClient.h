//
//  NetworkClient.h
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>
#import "ErrorManager.h"

#ifdef DEBUG


//#define RESTHOST @"http://192.168.1.100/kq/index.php/kqapi3"
//#define RESTHOST @"http://115.29.148.47/kq/index.php/kqapi3"
//#define RESTHOST @"http://61.153.100.241/kq/index.php/kqapi3"
#define RESTHOST @"http://61.153.100.241/kq/index.php/kqapi6"

#else

//#define HOST @"http://115.29.148.47/kq/index.php/kqavos"
//#define RESTHOST @"http://115.29.148.47/kq/index.php/kqapi3"
//#define RESTHOST @"http://115.29.148.47/kq/index.php/kqapi3"
#define RESTHOST @"http://61.153.100.241/kq/index.php/kqapi6"

#endif


@interface NetworkClient : NSObject{
    AFHTTPRequestOperationManager *_clientManager;
}


+ (id)sharedInstance;


/**
 *	@brief 获取用户个人信息
 *
 */
//- (void)queryUser:(NSString*)uid block:(IdResultBlock)block;

/**
 *	@brief 获取优惠券信息
 */

- (void)queryCoupon:(NSString*)couponId block:(IdResultBlock)block;



/**
 *	@brief	用户注册登录
 */

- (void)registerWithDict:(NSDictionary*)info block:(IdResultBlock)block;


/**
 *	@brief	Login 是会刷新sessionToken的
 *
 *	@param 	username 	用户手机号
 *	@param 	password 	md5字串
 *	@param 	block
 */
- (void)loginWithUsername:(NSString*)username password:(NSString*)password block:(IdResultBlock)block;


- (void)queryUserInfo:(NSString*)uid sessionToken:(NSString*)sessionToken block:(DictionaryResultBlock)block;

/**
 *	
 * @deprecated
 * @brief	获取用户收藏的商户,应该也不需要了
 */
- (void)queryShopBranches:(NSString*)parentId block:(IdResultBlock)block;




- (void)queryHotestCouponsSkip:(int)skip block:(IdResultBlock)block;
/**
 
 @brief   返回搜索的快券
 @params: districtId/subDistrictId/couponTypeId/subTypeId/keyword/latitude/longitude
 
 */
- (void)searchCoupons:(NSDictionary*)params block:(IdResultBlock)block;

/**
 deprecated , shop可以直接include coupons来获得
 */
- (void)queryCouponsWithShop:(NSString*)shopId block:(IdResultBlock)block;



/**
 *	@brief	获取所有一级商区
 */

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
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteCoupon:(NSString*)couponId block:(IdResultBlock)block;
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteCoupon:(NSString*)couponId block:(IdResultBlock)block;

/**
 *	@brief	获取用户收藏的商户
 */
- (void)queryFavoritedShop:(NSString*)uid block:(IdResultBlock)block;
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteShop:(NSString*)shopId block:(IdResultBlock)block;
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteShop:(NSString*)shopId block:(IdResultBlock)block;


/**
 *	@brief	忘记密码后的重置密码
 *
 *	@param 	username 	<#username description#>
 *	@param 	password 	md5密文
 *	@param 	block
 */
- (void)user:(NSString*)username resetPassword:(NSString*)password block:(IdResultBlock)block;

/**
 *	@brief 用户忘记密码时点击获得验证码
 */
- (void)requestCaptchaForgetPassword:(NSString*)username block:(IdResultBlock)block;

- (void)requestCaptchaRegister:(NSString*)username block:(IdResultBlock)block;

- (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
//- (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
//- (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;

- (void)test;

@end
