
//  AVOSEngine.m
//  TutorialBase
//
//  Created by AppDevelopper on 14-4-15.
//
//

#import "AVOSEngine.h"
#import <CoreLocation/CoreLocation.h>




@implementation AVOSEngine

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}


- (id)init{
    if (self = [super init]) {
        
//        [GSMAUser registerSubclass];
//        [GSMALogo registerSubclass];
//        [GSMAUserStatus registerSubclass];
      
    }
    
    return self;
}

#pragma mark - User

- (AVUser*)currentUser{

    return [PFUser currentUser];
    
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(IdResultBlock)block{
    
    [PFUser logInWithUsernameInBackground:username password:password block:block];
}

//
//- (void)loginWithEmail:(NSString *)email password:(NSString *)password block:(LoginBlock)block{
//    
//    [PFUser logInWithUsernameInBackground:email password:password block:block];
//}

- (void)logout{
    
    [PFUser logOut];
   
    AVUser * currentUser = [AVUser currentUser]; // 现在的currentUser是nil了

    NSLog(@"currentUser logout # %@",currentUser);
}

- (void)refreshUser{
    [[AVUser currentUser] refresh];
}

- (void)refreshUserWithBlock:(IdResultBlock)block{
    
    [[AVUser currentUser] refreshInBackgroundWithBlock:block];
    
}
- (void)registerWithUsername:(NSString*)username password:(NSString *)password block:(BooleanResultBlock)block{
    

    PFUser * user = [PFUser user];
    user.username = username;
    user.password =  password;
    
    [user setObject:@"213-253-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:block];
    
}
//
//- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(PFBooleanResultBlock)block{
//   
//    PFUser *user = [PFUser user];
//    user.username = userInfo[UserUsernameKey];
//    user.password = userInfo[UserPasswordKey];
//    user.email = userInfo[UserEmailKey];
//    
//    [user setObject:userInfo[UserFirstNameKey] forKey:UserFirstNameKey];
//    [user setObject:userInfo[UserLastNameKey] forKey:UserLastNameKey];
//    [user setObject:userInfo[UserTitleKey] forKey:UserTitleKey];
//    [user setObject:userInfo[UserPhoneKey] forKey:UserPhoneKey];
//   
//  
//    AVObject *userStatus = [GSMAUserStatus defaultUserStatus];
//    
//    [user setObject:userStatus forKey:UserStatusKey];
//    
//    // 注册的时候会更新location
//    [AVGeoPoint geoPointForCurrentLocationInBackground:^(AVGeoPoint *geoPoint, NSError *error) {
//        [userStatus setObject:geoPoint forKey:@"location"];
//        [userStatus saveInBackground];
//    }];
//    
//    [user signUpInBackgroundWithBlock:block];
//    
//}

- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block{
    [AVUser requestPasswordResetForEmailInBackground:email block:block];
}



#pragma mark - AVOS

- (void)saveImageForUser:(UIImage*)image key:(NSString*)key block:(BooleanResultBlock)block{
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    
    AVFile *file = [AVFile fileWithData:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [self.currentUser setObject:file forKey:key];
//        [self.currentUser saveInBackground];
        
        [self.currentUser saveInBackgroundWithBlock:block];
        
    }];

}

- (UIImage*)imageForUserKey:(NSString*)key{
    AVFile *avatarFile = [self.currentUser objectForKey:key];
    
    
    NSData *avatarData = [avatarFile getData];
    UIImage *avatar;
    
    if (!avatarData) {
        return nil;
    }
    else{
        avatar = [[UIImage alloc] initWithData:avatarData];
    }
    
    return avatar;

}

+ (UIImage*)imageForObject:(AVObject*)obj key:(NSString*)key{
    
    AVFile *avatarFile = [obj objectForKey:key];

    NSData *avatarData = [avatarFile getData];
    UIImage *avatar;
    if (!avatarData) {
        return nil;
    }
    else{
        avatar = [[UIImage alloc] initWithData:avatarData];
    }

    return avatar;
}


+ (void)queryClass:(NSString*)className objectId:(NSString*)objectId block:(ArrayResultBlock)block{
    
    AVQuery *query = [AVQuery queryWithClassName:className];
    [query whereKey:@"objectId" equalTo:objectId];
    [query findObjectsInBackgroundWithBlock:block];
    
}

+ (NSArray*)queryClass:(NSString*)className objectId:(NSString*)objectId{
    
    AVQuery *query = [AVQuery queryWithClassName:className];
    [query whereKey:@"objectId" equalTo:objectId];

    return [query findObjects];
}


- (void)getUserRelationObjectsForKey:(NSString*)key block:(ArrayResultBlock)block{
    AVRelation *relation = [self.currentUser relationforKey:key];
    
    [[relation query] findObjectsInBackgroundWithBlock:block];

}

- (void)addObject:(AVObject*)object forUserRelation:(NSString*)key{
    AVRelation *relation = [self.currentUser relationforKey:key];
    [relation addObject:object];
}


#pragma mark - Class Property

+ (NSDictionary*)avosPointerWithClassName:(NSString*)className objectId:(NSString*)objectId{

    return @{@"__type":@"Pointer",@"className":className,@"objectId":objectId};

}

+ (NSDictionary*)avosPointerWithField:(NSString*)field className:(NSString*)className objectId:(NSString*)objectId{
    

    return @{field:@{@"__type":@"Pointer",@"className":className,@"objectId":objectId}};

}

+ (CLLocation*)locationFromGeoPointDict:(NSDictionary*)dict{

    CLLocation *location = [[CLLocation alloc] initWithLatitude:[dict[@"latitude"] doubleValue] longitude:[dict[@"longitude"] doubleValue]];
    
    return location;
}

#pragma mark - Example


- (void)uploadImage:(UIImage*)img text:(NSString*)text block:(BooleanResultBlock)block{
    NSData *pictureData = UIImagePNGRepresentation(img);
    
    // Upload new picture
    // 1
    PFFile *image = [PFFile fileWithName:@"img" data:pictureData];
    
    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 2
            PFObject *wallImageObject = [PFObject objectWithClassName:@"WallImageObject"];
            wallImageObject[@"image"] = image;
            wallImageObject[@"user"] = [PFUser currentUser].username;
            wallImageObject[@"comment"] = text;
            
            // 3
            [wallImageObject saveInBackgroundWithBlock:block];
        } else {
            // 5
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    } progressBlock:^(NSInteger percentDone) {
        NSLog(@"Uploaded: %ld", (long)percentDone);
    }];
}

- (void)fetchWallImagesWithBlock:(ArrayResultBlock)block{
    PFQuery *query = [PFQuery queryWithClassName:@"WallImageObject"];
    
    // 2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:block];
    
}



- (void)queryUser{
    AVQuery * query = [AVUser query];
    [query whereKey:@"username" equalTo:@"111"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSLog(@"users # %@",objects);
        } else {
            
        }
    }];
}

- (void)addGeoPointToCurrentUser{
    AVGeoPoint * point = [AVGeoPoint geoPointWithLatitude:40.0 longitude:-30.0];
   
    [[AVUser currentUser] setObject:point forKey:@"location"];
    
    [AVCurrentUser save];
}


- (void)queryNearestUser{

    AVGeoPoint *point = [AVCurrentUser objectForKey:@"location"];
    AVQuery * query = [AVUser query];
    [query whereKey:@"location" nearGeoPoint:point];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            NSLog(@"users # %@",objects);
        } else {
            
        }
    }];
    
}


- (void)testArray{
    AVObject *gameScore = [AVObject objectWithClassName:@"GameScore"];
    [gameScore setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
    [gameScore setObject:@"aaa" forKey:@"playerName"];
    [gameScore setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
    [gameScore setObject:[NSArray arrayWithObjects:@"pwnage", @"flying", nil] forKey:@"skills"];
    [gameScore addObject:@"cheat" forKey:@"skills"];
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        

        // Now let's update it with some new data. In this case, only cheatMode and score
//        // will get sent to the cloud. playerName hasn't changed.
//        [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
//        [gameScore setObject:[NSNumber numberWithInt:1338] forKey:@"score"];
//        [gameScore saveInBackground];
    }];
}

- (void)testIncrement{

    AVQuery *query = [AVQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"53625166e4b02b7ca3bc38f9" block:^(AVObject *gameScore, NSError *error) {
        [gameScore incrementKey:@"score" byAmount:@10];

        [gameScore saveInBackground];
    }];
}
//
//- (void)testAddRelationObject{
//    AVQuery *query = [AVQuery queryWithClassName:@"Logo"];
//    [query whereKey:@"name" equalTo:@"双子"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        GSMALogo *logo = objects[0];
//        NSLog(@"name # %@",logo.name);
//        
//        AVRelation *logos = [self.currentUser relationforKey:@"logos"];
//        [logos addObject:logo];
//        
//        [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            NSLog(@"saved");
//        }];
//    }];
//
//}

- (void)testGetRelationObjects{
    AVRelation *logos = [self.currentUser relationforKey:@"logos"];
    
    [[logos query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"logos # %@",objects);
    }];
//
}
//
//- (void)testRestGET{
//    
//    L();
//    
//    AFHTTPRequestOperationManager *clientManager = [AFHTTPRequestOperationManager manager];
//
//    AFHTTPRequestSerializer *serialization = [AFHTTPRequestSerializer serializer];
//    [serialization setValue:@"y9yn2jb34lih2m69gqmupd8m0ig63g151xtngi8jxwxotdr7" forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
//    
//    
//    [serialization setValue:@"juf4qlrphp63x9nfpmchrbnvadm7boszoonj0f3w1n8xa4zu" forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
//    
//    clientManager.requestSerializer = serialization;
//    
//    AFHTTPRequestOperation *operation = [clientManager GET:@"https://cn.avoscloud.com/1/login" parameters:@{@"username":@"tominfrankfurt@gmail.com",@"password":@"111222"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"response string: %@ ", operation.responseString);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//      
//          NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"error: %@", operation.responseString);
//        
//
//
//    }];
//    
//    [operation start];
//}
//
//- (void)testLocalRestGET{
//    
//    L();
//    
//    AFHTTPRequestOperationManager *clientManager = [AFHTTPRequestOperationManager manager];
//    
////    AFHTTPRequestSerializer *serialization = [AFHTTPRequestSerializer serializer];
////    [serialization setValue:@"y9yn2jb34lih2m69gqmupd8m0ig63g151xtngi8jxwxotdr7" forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
////    
////    
////    [serialization setValue:@"juf4qlrphp63x9nfpmchrbnvadm7boszoonj0f3w1n8xa4zu" forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
////    
////    clientManager.requestSerializer = serialization;
//    
//    AFHTTPRequestOperation *operation = [clientManager GET:@"http://localhost/syhci/index.php/apis/gsma/test" parameters:@{@"username":@"tominfrankfurt@gmail.com",@"password":@"111222"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"response string: %@ ", operation.responseString);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"error: %@", operation.responseString);
//        
//        
//        
//    }];
//    
//    [operation start];
//}
//
//- (void)testAVOSUser{
//
//    AFHTTPRequestOperationManager *clientManager = [AFHTTPRequestOperationManager manager];
//    
//    AFHTTPRequestSerializer *serialization = [AFHTTPRequestSerializer serializer];
//    [serialization setValue:@"y9yn2jb34lih2m69gqmupd8m0ig63g151xtngi8jxwxotdr7" forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
//    
//    [serialization setValue:@"juf4qlrphp63x9nfpmchrbnvadm7boszoonj0f3w1n8xa4zu" forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
//    
//    clientManager.requestSerializer = serialization;
//    
//    //534d4f9ee4b0275ea1a0c24e
//    AFHTTPRequestOperation *operation = [clientManager GET:@"https://cn.avoscloud.com/1/users" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"response string: %@ ", operation.responseString);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"operation hasAcceptableStatusCode: %d", [operation.response statusCode]);
//        
//        NSLog(@"error: %@", operation.responseString);
//        
//        
//        
//    }];
//    
//    [operation start];
//
//}

- (void)test{
    //    [self testArray];
    
    L();
     
    //    [self testIncrement];
    
    //    AVObject *gameScore
    
//    [self testRestGET];
    
//    [self testAVOSUser];
    
//    [self createUserStatus];
    
    
//    AVObject *logo = _allLogos[0];
//    NSLog(@"logo # %@",logo);
    
//    NSLog(@"before query");
//    AVQuery * query = [AVUser query];
//    
//    NSArray *arr =  [query findObjects:nil];
//    
//    NSLog(@"after query");
    
//    for (GSMALogo *logo in _allLogos) {
//        NSLog(@"locationX # %f",logo.locationX);
//    }

//    [AVGeoPoint geoPointForCurrentLocationInBackground:^(AVGeoPoint *geoPoint, NSError *error) {
//        
//        if (!geoPoint) {
//            NSLog(@"nil point");
//        }
//        NSLog(@"avgeopoint without location # %@",geoPoint);
//        
//        CLLocationCoordinate2D test = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
//        
//        NSDictionary*  testdic = BMKBaiduCoorForWgs84(test);
//        
//        CLLocationCoordinate2D newCord =  BMKCoorDictionaryDecode(testdic);
//        NSLog(@"common # %f,%f",newCord.latitude,newCord.longitude);
//        
//    }];
    
    //add relation
    
}


@end
