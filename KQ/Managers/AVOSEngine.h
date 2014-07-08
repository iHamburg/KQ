//
//  AVOSEngine.h
//  TutorialBase
//
//  Created by AppDevelopper on 14-4-15.
//
//


#import <AVOSCloud/AVOSCloud.h>


#define AVCurrentUser [AVUser currentUser]

@interface AVOSEngine : NSObject

+ (id)sharedInstance;

- (AVUser*)currentUser;



- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block;
- (void)refreshUser;
- (void)refreshUserWithBlock:(IdResultBlock)block;
- (void)logout;

- (void)getUserRelationObjectsForKey:(NSString*)key block:(ArrayResultBlock)block;
- (void)addObject:(id)object forUserRelation:(NSString*)key;


- (void)saveImageForUser:(UIImage*)image key:(NSString*)key block:(BooleanResultBlock)block;
- (UIImage*)imageForUserKey:(NSString*)key;


+ (UIImage*)imageForObject:(AVObject*)obj key:(NSString*)key;
+ (NSArray*)queryClass:(NSString*)className objectId:(NSString*)objectId;
+ (void)queryClass:(NSString*)className objectId:(NSString*)objectId block:(ArrayResultBlock)block;

+ (NSDictionary*)avosPointerWithField:(NSString*)field className:(NSString*)className objectId:(NSString*)objectId;
+ (NSDictionary*)avosPointerWithClassName:(NSString*)className objectId:(NSString*)objectId;
+ (CLLocation*)locationFromGeoPointDict:(NSDictionary*)dict;

- (void)test;
@end
