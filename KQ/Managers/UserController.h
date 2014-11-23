//
//  UserController.h
//  PushDemo
//
//  Created by AppDevelopper on 14-4-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "People.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import <CoreLocation/CoreLocation.h>

@interface UserController : NSObject<CLLocationManagerDelegate>{
   
    People *_people;
    NetworkClient *_networkClient;
    CLLocationManager *_locationManager;
    CLLocation *_checkinLocation;
}


@property (nonatomic, strong) People *people;

@property (nonatomic, strong) CLLocation *checkinLocation;  //用户的当前位置



@property (nonatomic, readonly) NSString *uid;
@property (nonatomic, readonly) NSString *sessionToken;
@property (nonatomic, readonly) BOOL isLogin;
@property (nonatomic, readonly) BOOL hasBankcard;
@property (nonatomic, readonly) NSString *longitude;
@property (nonatomic, readonly) NSString *latitude;

+ (id)sharedInstance;


/**
 *	@brief	用户注册
 *
 *	@param 	userInfo 	username, password(md5)
 *	@param 	block       Boolean
 */
- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(BooleanResultBlock)block;

/**
 *	@brief	用户登录，UserController获得people对象
 *
 *	@param 	username 	手机号
 *	@param 	pw 	        md5
 *	@param 	block       Boolean
 */
- (void)loginWithUsername:(NSString*)username password:(NSString*)pw boolBlock:(BooleanResultBlock)block;


/**
 *	@brief	有必要中间加这个函数，这样VC就不用直接和user:editInfo: 打交道了
 *
 *	@param 	nickname 	<#nickname description#>
 *	@param 	block 	<#block description#>
 */
- (void)changeNickname:(NSString *)nickname boolBlock:(BooleanResultBlock)block;


/**
 *	@brief
 *
 *	@param 	img 	要是小尺寸的图片
 *	@param 	block 	<#block description#>
 */
- (void)changeAvatar:(UIImage*)img boolBlock:(BooleanResultBlock)block;

/**
 *	@brief	<#Description#>
 *
 *	@param 	oldPwd 	明文
 *	@param 	newPwd 	明文
 *	@param 	block 	<#block description#>
 */
- (void)changePwd:(NSString*)oldPwd newPwd:(NSString*)newPwd boolBlock:(BooleanResultBlock)block;


/**
 *	@brief	从queryUserInfo接口更新user的app info
 *
 *	@param 	dict 	<#dict description#>
 */
- (BOOL)updateUserInfo:(NSDictionary*)dict;

//获得用户信息，判断session是否过期
- (void)updateUserInfoWithBlock:(BooleanResultBlock)block;

- (void)logout;


- (CLLocationDistance)distanceFromLocation:(CLLocation*)location;


/**
 *	@brief	把People信息保存到NSDefautls中
 *
 *	@param 	people 	<#people description#>
 */
- (void)savePeople:(People*)people;

- (People*)loadPeople;


- (void)test;

@end
