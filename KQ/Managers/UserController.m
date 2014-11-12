//
//  UserController.m
//  PushDemo
//
//  Created by AppDevelopper on 14-4-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserController.h"
#import <MapKit/MapKit.h>

#import "Card.h"
#import "ErrorManager.h"
#import "LibraryManager.h"


@interface UserController (){

    
}


@end


@implementation UserController


- (void)setAvatar:(UIImage *)avatar{
    //
//    [[AVOSEngine sharedInstance] saveImageForUser:avatar key:@"avatar" block:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            [self loadUser];
//        }
//    }];
}

- (BOOL)isLogin{
    
    
    if (self.uid) {
        return YES;
    }
    else
        return NO;
}

- (BOOL)hasBankcard{
    
    if (!self.isLogin) {
        return NO;
    }
    else if(ISEMPTY(self.people.cardIds)){
        return NO;
    }
    else
        return YES;
}

#pragma mark - Init

+ (id)sharedInstance {
    static dispatch_once_t once;
    
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // user login! username, password, session
        
        _networkClient = [NetworkClient sharedInstance];
        

        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
        People *people = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"people # %@",people.username);
        
        //如果记录有uid的话就login
        NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
        NSString *sessionToken =[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionToken"];

        NSLog(@"uid # %@, token # %@",uid,sessionToken);
    
        
        if (!ISEMPTY(uid) && !ISEMPTY(sessionToken)) {
            self.uid = uid;
            self.sessionToken = sessionToken;
            //判断session是否过期
           
            [_networkClient queryUserInfo:self.uid sessionToken:self.sessionToken block:^(NSDictionary* dict, NSError *error) {
                
                if (!error) {
                // 如果没有出错
                    NSLog(@"dict # %@",dict);
                    
                }
                else{
                    int code = error.code;
                    
                    if (code == ErrorInvalidSession){
                    // 如果是session过期，logout
                        
                        [self logout];
                    }
                    else{
                    // 其他的错误就显示给用户
                        
                        [ErrorManager alertError:error];
                    }
                }
     
            }];
            
        }
        
        self.checkinLocation = [[CLLocation alloc] initWithLatitude:31.02 longitude:121.02];
        
        [self setupLocationManager];
        
        
    }
    return self;
}



#pragma mark - Location

- (void) setupLocationManager {
    
    _locationManager = [[CLLocationManager alloc] init] ;
    if ([CLLocationManager locationServicesEnabled]) {
        //        NSLog( @"Starting CLLocationManager" );
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 500;
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.activityType = CLActivityTypeOther;
        [_locationManager startUpdatingLocation];
        
        //        [_locationManager startMonitoringSignificantLocationChanges];
    } else {
        NSLog( @"Cannot Starting CLLocationManager" );
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    L();
    
    _checkinLocation = newLocation;
    
}

- (CLLocationDistance)distanceFromLocation:(CLLocation*)location{
    return [_checkinLocation distanceFromLocation:location];
}

#pragma mark - Fcns

//- (void)loadUser{

//    self.uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//    self.sessionToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
 

//    [_networkClient queryUser:self.uid block:^(NSDictionary *dict, NSError *error) {
    
//        if (!ISEMPTY(dict)) {
//            self.people = [People peopleWithDict:dict];
//            
//        }
//        
//        [_networkClient queryCards:self.uid block:^(NSArray *array, NSError *error) {
//            
////            NSLog(@"cards # %@",array);
//            
//            if (ISEMPTY(array)) {
//                return ;
//            }
//            
//            self.people.cardIds = [NSMutableSet set];
//            
//            for (NSDictionary *dict in array) {
//                [self.people.cardIds addObject:dict[@"objectId"]];
//                
//            }
////            NSLog(@"people.cardIds # %@",self.people.cardIds);
//        }];
        
//    }];
//}



- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(BooleanResultBlock)block{
    
    
    [[NetworkClient sharedInstance] registerWithDict:userInfo block:^(NSDictionary *dict, NSError *error) {
       
        if (!error) {
            // 如果注册成功
            
            block(YES,nil);
        }
        else{
            // 注册失败
            [ErrorManager alertError:error];
            
            block(NO,error);
            
        }
    }];

    
}


- (void)loginWithUsername:(NSString*)email password:(NSString*)pw boolBlock:(BooleanResultBlock)block{
    
//    NSLog(@"pw # %@",pw);
  
  
    
    [[NetworkClient sharedInstance] loginWithUsername:email password:pw block:^(NSDictionary *dict, NSError *error) {
        
        if (!error) {
            // 如果没有出错
        
            self.uid = dict[@"id"];
            self.sessionToken = dict[@"sessionToken"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:self.uid forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults] setObject:self.sessionToken forKey:@"sessionToken"];
            
            // 载入信息到当前的user！
            
            self.people = [People peopleWithDict:dict];
            self.people.password = pw;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.people];
            [defaults setObject:data forKey:@"User"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            
            block(YES,nil);
        }
        else{

            [ErrorManager alertError:error];

            block(NO,error);
            
        }

   
    }];

}



- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block{
    
//    [_engine requestPasswordResetForEmailInBackground:email block:block];
}

- (void)logout{
    
    self.uid = nil;
    self.sessionToken = nil;
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
       
}



#pragma mark - Test
- (void)test{
    L();

//    [People people];
//    [People people];
    
    
//    
//    MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
//    formatter.units = MKDistanceFormatterUnitsMetric;
//    NSLog(@"%@", [formatter stringFromDistance:distance]); // 535 miles
}
@end
