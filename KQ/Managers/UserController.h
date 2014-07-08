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

@property (nonatomic, strong) CLLocation *checkinLocation;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *sessionToken;


+ (id)sharedInstance;


- (BOOL)isLogin;

- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(BooleanResultBlock)block;
- (void)loginWithEmail:(NSString*)email pw:(NSString*)pw block:(BooleanResultBlock)block;
- (void)logout;

- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block;

- (void)loadUser;

- (CLLocationDistance)distanceFromLocation:(CLLocation*)location;

- (void)test;
@end
