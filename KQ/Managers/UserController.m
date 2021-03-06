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
#import "NSString+md5.h"

@interface UserController (){

    
}


@end


@implementation UserController



- (NSString*)uid{
    
    return self.people.id;
}

- (NSString*)sessionToken{
    return self.people.sessionToken;
}

- (BOOL)isLogin{
    
    
    if (self.people) {
        return YES;
    }
    else
        return NO;
}

- (int)cardNum{
    if (self.isLogin) {
        return self.people.cardNum;
    }
    
    return 0;
}


- (NSString*)longitude{
    
    
    return [NSString stringWithFormat:@"%.3f",_checkinLocation.coordinate.longitude];

}

- (NSString*)latitude{
    
    return [NSString stringWithFormat:@"%.3f",_checkinLocation.coordinate.latitude];
    
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
        

        self.people = [self loadPeople];
        NSLog(@"people # %@",self.people);
        
        // 如果用户已经登陆的话
        if (!ISEMPTY(self.people)) {
           
            //获得用户信息，判断session是否过期
           
            [self updateUserInfoWithBlock:^(BOOL succeeded, NSError *error) {
                
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
    
//    float longitude =_checkinLocation.coordinate.longitude;
//    NSLog(@"longitude # %f",longitude);
//    
//    NSString *longi = [NSString stringWithFormat:@"%.3f",longitude];
//    NSLog(@"string # %@",longi);
    
}

- (CLLocationDistance)distanceFromLocation:(CLLocation*)location{
    return [_checkinLocation distanceFromLocation:location];
}

#pragma mark - Fcns

// 注册成功也是login
- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(BooleanResultBlock)block{
    
    
    [_networkClient registerWithDict:userInfo block:^(NSDictionary *dict, NSError *error) {
       
        if (!error) {
            // 如果注册成功, 自动login获得信息
            
            // 如果注册成功， 后台login 一下获得用户的咨询
            NSString *username = userInfo[@"username"];
            NSString *password = userInfo[@"password"];
            
            [self loginWithUsername:username password:password boolBlock:^(BOOL succeeded, NSError *error) {
                  block(YES,nil);
            }];
        
        }
        else{
            // 注册失败
            [ErrorManager alertError:error];
            
            block(NO,error);
            
        }
        
    }];

}

// login 会自动调用updateUserInfo
- (void)loginWithUsername:(NSString*)email password:(NSString*)pw boolBlock:(BooleanResultBlock)block{
    
//    NSLog(@"pw # %@",pw);
  
    [_networkClient loginWithUsername:email password:pw block:^(NSDictionary *dict, NSError *error) {
        
        if (!error) {
            // 载入信息到当前的user！
            
            self.people = [[People alloc] initWithDict:dict];
            self.people.password = pw;
            // 新登录时从userdefaults中获取lastNewsId
            self.people.lastNewsId = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastNewsId"];

            
            [self savePeople:self.people];
            
            // 如果登录成功就更新信息
            [self updateUserInfoWithBlock:^(BOOL succeeded, NSError *error) {
                    block(YES,nil);
            }];
   
        }
        else{

            [ErrorManager alertError:error];

            block(NO,error);
            
        }

   
    }];

}

- (void)changeNickname:(NSString *)nickname boolBlock:(BooleanResultBlock)block{
    
    NSDictionary *dict = @{@"uid":self.uid,@"sessionToken":self.sessionToken,@"nickname":nickname};
    
    [_networkClient user:self.uid editInfo:dict block:^(NSDictionary *dict, NSError *error) {
       
        if (!error) {
            
            self.people.nickname = dict[@"nickname"];
            
            // 保存people
            [self savePeople:self.people];
            
            block(YES,nil);
        }
        else{
            [ErrorManager alertError:error];
            
            block(NO,error);
        }
    }];
    
}

- (void)changeAvatar:(UIImage*)img boolBlock:(BooleanResultBlock)block{
    
    NSData *_data = UIImageJPEGRepresentation(img, .8f);
    
    NSString *_encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dict = @{@"uid":self.uid,@"sessionToken":self.sessionToken,@"avatar":_encodedImageStr};
    
    
    [_networkClient user:self.uid editInfo:dict block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                dict = [dict dictionaryCheckNull];
            }
            self.people.avatarUrl = dict[@"avatarUrl"];
            [self savePeople:self.people];
            
            block(YES,nil);
        }
        else{
            [ErrorManager alertError:error];
            block(NO,error);
        }
    }];

}

- (void)changePwd:(NSString*)oldPwd newPwd:(NSString*)newPwd boolBlock:(BooleanResultBlock)block{
    
    NSDictionary *pwdDict = @{@"oldPassword":[oldPwd stringWithMD5],@"newPassword":[newPwd stringWithMD5]};
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:pwdDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
     NSDictionary *dict = @{@"uid":self.uid,@"sessionToken":self.sessionToken,@"password":jsonStr};
    
    [_networkClient user:self.uid editInfo:dict block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
     
            self.people.password = newPwd;
            [self savePeople:self.people];
            
            block(YES,nil);
        }
        else{
            [ErrorManager alertError:error];
            block(NO,error);
        }
    }];

    
}

- (void)updateUserInfoWithBlock:(BooleanResultBlock)block{
    
    [_networkClient queryUserInfo:self.uid sessionToken:self.sessionToken block:^(NSDictionary* dict, NSError *error) {
        
        if (!error) {
            // 如果没有出错
            //                    NSLog(@"dict # %@",dict);
            if ([dict isKindOfClass:[NSDictionary class]]) {
                dict = [dict dictionaryCheckNull];
            }
            
            
            self.people.dCouponNum = [dict[@"dCouponNum"] intValue];
//            self.people.dCouponNum = 0;
            
            self.people.cardNum = [dict[@"cardNum"] intValue];

//                 self.people.cardNum = 0;
            self.people.fCouponNum = [dict[@"fCouponNum"] intValue];
            self.people.fShopNum = [dict[@"fShopNum"] intValue];
            
            block(YES,nil);
        }
        else{
            int code = error.code;
            
            if (code == ErrorInvalidSession){
                // 如果是session过期，logout
                
                [self logout];
            }
            block(NO,error);
            
        }
        
    }];

    
}
//- (BOOL)updateUserInfo:(NSDictionary*)dict{
//    
//    if (!self.people) {
//        return NO;
//    }
//    
//    self.people.dCouponNum = [dict[@"dCouponNum"] intValue];
//    self.people.cardNum = [dict[@"cardNum"] intValue];
//    self.people.fCouponNum = [dict[@"fCouponNum"] intValue];
//    self.people.fShopNum = [dict[@"fShopNum"] intValue];
//
//    return YES;
//    
//}

- (void)logout{
    

    // 退出之前记下newsId，可以根据username来定！
    [[NSUserDefaults standardUserDefaults] setInteger:self.people.lastNewsId forKey:@"lastNewsId"];
    
    self.people = nil;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"User"];
  
    [[NSUserDefaults standardUserDefaults] synchronize];
    
       
}

- (void)savePeople:(People*)people{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:people];
    [defaults setObject:data forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (People*)loadPeople{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    People *people = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return people;
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
