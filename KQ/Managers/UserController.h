//
//  UserController.h
//  PushDemo
//
//  Created by AppDevelopper on 14-4-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//


#import "People.h"
#import "NetworkClient.h"
#import <CoreLocation/CoreLocation.h>

@interface UserController : NSObject<CLLocationManagerDelegate>{
   
    People *_people;
    NetworkClient *_networkClient;
    CLLocationManager *_locationManager;
    CLLocation *_checkinLocation;
}


@property (nonatomic, strong) People *people;

@property (nonatomic, strong) CLLocation *checkinLocation;  //用户的当前位置
@property (nonatomic, strong) UIImage *avatar;


@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *sessionToken;

@property (nonatomic, readonly) BOOL isLogin;
@property (nonatomic, readonly) BOOL hasBankcard;

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


- (void)logout;

- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block;

//- (void)loadUser;

- (CLLocationDistance)distanceFromLocation:(CLLocation*)location;

- (void)test;

@end
