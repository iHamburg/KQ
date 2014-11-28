//
//  NetworkClient.m
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetworkClient.h"
#import "NSString+md5.h"
#import "ErrorManager.h"


//获取最新的优惠券
#define api_newestCoupons       [RESTHOST stringByAppendingFormat:@"/newestCoupons"]

#define api_hotestCoupons       [RESTHOST stringByAppendingFormat:@"/hotestCoupons"]

//搜索优惠券
#define api_searchCoupons        [RESTHOST stringByAppendingFormat:@"/searchCoupons"]

//附件门店
#define api_search_shopbranches        [RESTHOST stringByAppendingFormat:@"/aroundShopbranches"]



//获取优惠券
#define api_coupon              [RESTHOST stringByAppendingFormat:@"/couponDetails"]

//获取门店详情
#define api_shopBranch              [RESTHOST stringByAppendingFormat:@"/shopbranchDetails"]

//获取所有门店列表
#define api_all_shopBranches    [RESTHOST stringByAppendingFormat:@"/allShopbranches"]

//获取区域
#define api_district             [RESTHOST stringByAppendingFormat:@"/district"]


//获取一级区域
#define api_headDistricts        [RESTHOST stringByAppendingFormat:@"/district"]

//获取一级类型
#define api_headCouponTypes       [RESTHOST stringByAppendingFormat:@"/shopType"]



//用户登录
#define api_login               [RESTHOST stringByAppendingString:@"/login"]

//用户注册
#define api_user                [RESTHOST stringByAppendingFormat:@"/user"]

// 获取用户信息
#define api_userinfo            [RESTHOST stringByAppendingFormat:@"/userInfo"]

// 修改用户信息
#define api_edituserInfo        [RESTHOST stringByAppendingFormat:@"/editUserInfo"]

//用户绑定的银行卡
#define api_my_card             [RESTHOST stringByAppendingFormat:@"/mycard"]

#define api_my_card_delete      [RESTHOST stringByAppendingFormat:@"/deleteMyCard"]

//用户下载的快券
#define api_my_downloadedCoupon [RESTHOST stringByAppendingFormat:@"/myDownloadedCoupon"]


//用户收藏的快券
#define api_my_favoritedCoupon  [RESTHOST stringByAppendingFormat:@"/myFavoritedCoupon"]

#define api_my_unfavoriteCoupon     [RESTHOST stringByAppendingFormat:@"/deleteMyFavoritedCoupon"]

#define api_if_favoritedCoupon   [RESTHOST stringByAppendingFormat:@"/isFavoritedCoupon"]

//用户收藏的门店
#define api_my_favoritedShop    [RESTHOST stringByAppendingFormat:@"/myFavoritedShopbranch"]

#define api_my_unfavoriteShop      [RESTHOST stringByAppendingFormat:@"/deleteMyFavoritedShopbranch"]

#define api_if_favoritedShop     [RESTHOST stringByAppendingFormat:@"/isFavoritedShopbranch"]

// 用户的站内信
#define api_my_news             [RESTHOST stringByAppendingFormat:@"/myNews"]
// 用户编辑信息
#define api_edit_user_info       [RESTHOST stringByAppendingFormat:@"/editUserInfo"]

// 用户重置密码
#define api_reset_password    [RESTHOST stringByAppendingFormat:@"/resetPassword"]

// 用户忘记密码的验证码
#define api_requestCaptchaForgetPassword [RESTHOST stringByAppendingFormat:@"/captchaforgetpwd"]

// 用户注册的验证码
#define api_captcha_register    [RESTHOST stringByAppendingFormat:@"/captcharegister"]

@interface NetworkClient (){
    
}


@end

@implementation NetworkClient

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clientManager = [AFHTTPRequestOperationManager manager];
        
        
        // 必加的
        _clientManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

        [_clientManager.requestSerializer setValue:@"Close" forHTTPHeaderField:@"Connection"];
        [_clientManager.requestSerializer setValue:@"10" forHTTPHeaderField:@"Keep-Alive"];
        
//        [_clientManager.req]
        
        
        

    }
    return self;
}

#pragma mark -
- (void)registerWithDict:(NSDictionary*)info block:(IdResultBlock)block{
    
    
    
    [self postWithUrl:api_user parameters:info block:block];
    
}

- (void)loginWithUsername:(NSString*)username password:(NSString*)password block:(IdResultBlock)block{

    [self getWithUrl:api_login parameters:@{@"username":username,@"password":password,@"device":@"iOS"} block:block];
  
    
}

- (void)user:(NSString*)username resetPassword:(NSString*)password block:(IdResultBlock)block{
    
    [self postWithUrl:api_reset_password parameters:@{@"username":username,@"password":password} block:block];
}


- (void)queryUserInfo:(NSString*)uid sessionToken:(NSString*)sessionToken block:(DictionaryResultBlock)block{
    
    [self getWithUrl:api_userinfo parameters:@{@"uid":uid,@"sessionToken":sessionToken} block:block];
    
}

- (void)user:(NSString*)uid editInfo:(NSDictionary*)dict block:(IdResultBlock)block{
    
    [self postWithUrl:api_edit_user_info parameters:dict block:block];
}

#pragma mark - My Card
- (void)queryCards:(NSString*)uid block:(IdResultBlock)block{
    
    [self getWithUrl:api_my_card parameters:@{@"uid":uid} block:block];
    
}

- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken addCard:(NSString*)cardNumber block:(IdResultBlock)block{

    NSDictionary *params = @{@"uid":uid,@"card":cardNumber,@"sessionToken":sessionToken};
    [self postWithUrl:api_my_card parameters:params block:block];
}

- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken deleteCard:(NSString*)cardNumber block:(IdResultBlock)block{

    NSDictionary *params = @{@"uid":uid,@"card":cardNumber,@"sessionToken":sessionToken};
  
    [self postWithUrl:api_my_card_delete parameters:params block:block];
    
}

#pragma mark - My DownloadedCoupons

- (void)queryDownloadedCoupon:(NSString*)uid mode:(NSString*)mode skip:(int)skip block:(IdResultBlock)block;{
 

    NSDictionary *params = @{@"uid":uid,@"skip":[NSString stringWithInt:skip],@"mode":mode};
    
    [self getWithUrl:api_my_downloadedCoupon parameters:params block:block];
}


- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken downloadCoupon:(NSString*)couponId  block:(IdResultBlock)block{
    
    
    [self postWithUrl:api_my_downloadedCoupon parameters:@{@"uid":uid,@"couponId":couponId,@"sessionToken":sessionToken} block:block];
}

#pragma mark - My FavoritedCoupons
- (void)queryFavoritedCoupon:(NSString*)uid skip:(int)skip block:(IdResultBlock)block{
  
    [self getWithUrl:api_my_favoritedCoupon parameters:@{@"uid":uid,@"skip":[NSString stringWithInt:skip]} block:block];
}

- (void)queryIfFavoritedCouupon:(NSString*)uid couponId:(NSString*)couponId block:(IdResultBlock)block{
    [self getWithUrl:api_if_favoritedCoupon parameters:@{@"uid":uid,@"couponId":couponId} block:block];
}

- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteCoupon:(NSString*)couponId block:(IdResultBlock)block{
    
//    NSString *sessionToken = [[UserController sharedInstance] sessionToken];
    
    [self postWithUrl:api_my_favoritedCoupon parameters:@{@"uid":uid,@"couponId":couponId,@"sessionToken":sessionToken} block:block];
    
    
}
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteCoupon:(NSString*)couponId block:(IdResultBlock)block{


    [self postWithUrl:api_my_unfavoriteCoupon parameters:@{@"uid":uid,@"couponId":couponId,@"sessionToken":sessionToken} block:block];
    
//    [self deleteWithUrl:api_my_favoritedCoupon_delete(uid,sessionToken, couponId) parameters:nil block:block];
    
}


#pragma mark - My FavoritedShops
- (void)queryFavoritedShop:(NSString*)uid skip:(int)skip block:(IdResultBlock)block{
  
    [self getWithUrl:api_my_favoritedShop parameters:@{@"uid":uid,@"skip":[NSString stringWithInt:skip]} block:block];
    
}

- (void)queryIfFavoritedShop:(NSString*)uid shopId:(NSString*)shopId block:(IdResultBlock)block{

    [self getWithUrl:api_if_favoritedShop parameters:@{@"uid":uid,@"shopbranchId":shopId} block:block];
}

- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteShop:(NSString*)shopId block:(IdResultBlock)block{
    
    [self postWithUrl:api_my_favoritedShop parameters:@{@"uid":uid,@"shopbranchId":shopId,@"sessionToken":sessionToken} block:block];
    
}
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteShop:(NSString*)shopId block:(IdResultBlock)block{

    
    [self postWithUrl:api_my_unfavoriteShop parameters:@{@"uid":uid,@"shopbranchId":shopId,@"sessionToken":sessionToken} block:block];
    
//    [self deleteWithUrl:api_my_favoritedShop_delete(uid,sessionToken, shopId) parameters:nil block:block];
    
}



#pragma mark - My News
- (void)queryUserNews:(NSString*)uid skip:(int)skip limit:(int)limit lastNewsId:(int)lastNewsId  block:(IdResultBlock)block{
    
    
    if (limit == 0) {
        limit = 30;
    }
    
    [self getWithUrl:api_my_news parameters:@{@"uid":uid,@"skip":[NSString stringWithInt:skip],@"lastNewsId":[NSString stringWithInt:lastNewsId],@"limit":[NSString stringWithInt:limit]} block:block];
    
}

#pragma mark -

- (void)queryCoupon:(NSString*)couponId latitude:(NSString*)latitude longitude:(NSString*)longitude block:(IdResultBlock)block{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:couponId forKey:@"id"];
    if (!ISEMPTY(latitude)) {
        [params setValue:latitude forKey:@"latitude"];
    }
    if (!ISEMPTY(longitude)) {
        [params setValue:longitude forKey:@"longitude"];
    }
    
    [self getWithUrl:api_coupon parameters:params block:block];
    
}

- (void)queryShopBranch:(NSString*)shopId block:(IdResultBlock)block{
    
    
    [self getWithUrl:api_shopBranch parameters:@{@"id":shopId} block:block];
}

- (void)queryAllShopBranches:(NSString*)headerShopId block:(IdResultBlock)block{

    [self getWithUrl:api_all_shopBranches parameters:@{@"id":headerShopId} block:block];
}
- (void)queryHotestCouponsSkip:(int)skip block:(IdResultBlock)block{
    
    
    [self getWithUrl:api_hotestCoupons parameters:@{@"skip":[NSString stringWithInt:skip]} block:block];
}


/// deprecated
- (void)queryCouponsWithShop:(NSString*)shopId block:(IdResultBlock)block{
    //
    //
    //
    //    NSString *url = [RESTHOST stringByAppendingFormat:@"/coupon"];
    //
    //     NSDictionary *params = @{@"where":[AVOSEngine avosPointerWithField:@"shop" className:@"Shop" objectId:shopId]} ;
    //
    //    NSLog(@"params # %@",params);
    //
    //    [self getWithUrl:url parameters:params block:block];
}




- (void)queryHeadDistrictsWithBlock:(IdResultBlock)block{
    
    
    [self getWithUrl:api_headDistricts parameters:nil block:block];
    
}

- (void)queryHeadCouponTypesWithBlock:(IdResultBlock)block{
    
    [self getWithUrl:api_headCouponTypes parameters:nil block:block];
    
}



- (void)searchCoupons:(NSDictionary*)params block:(IdResultBlock)block{
    
    [self getWithUrl:api_searchCoupons parameters:params block:block];
}

- (void)searchShopBranches:(NSDictionary*)params block:(IdResultBlock)block{

    [self getWithUrl:api_search_shopbranches parameters:params block:block];
}

- (void)requestCaptchaForgetPassword:(NSString*)username block:(IdResultBlock)block{
    
    [self getWithUrl:api_requestCaptchaForgetPassword parameters:@{@"mobile":username} block:block];
}

- (void)requestCaptchaRegister:(NSString*)username block:(IdResultBlock)block{
    
    [self getWithUrl:api_captcha_register parameters:@{@"mobile":username} block:block];
}



#pragma mark - Intern Fcns


- (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
   
//
    
    
    AFHTTPRequestOperation *operation = [_clientManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"get url # %@,response : %@ ", url,responseObject);
//        NSLog(@"operation code # %d, obj # %@",operation.response.statusCode,responseObject);
        
        
        
        ///处理如果返回200，但是空值的错误
        if (ISEMPTY(responseObject)) {
           
            NSError *error = [NSError errorWithDomain:kKQErrorDomain code:ErrorClientSuccessNil userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: ErrorClientSuccessNil]}];
            
            block(nil,error);
        }
        
        NSDictionary *dict = responseObject;
        
        int code = [dict[@"status"] intValue];
        
        if ([dict[@"status"] intValue] == 1) {
        // 如果status为1，则直接返回data
            block (dict[@"data"],nil);
        
        }
        else{
            
            // 根据status码生成error，传给block
            
            // 查找本地有没有错误对应的msg
            NSString *msg = [ErrorManager localizedDescriptionForCode:code];
            
            //如果本地没有msg，就调用服务器的msg
            if (ISEMPTY(msg)) {
                msg = dict[@"msg"];
            }
            NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:msg}];
            
            block(nil,error);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        // 如果json不能解析的话
        // AFNetworkingErrorDomain 服务器的404或500错误
//        NSLog(@"get url %@,response # %@, error # %@,error status code # %d, domain # %@",url, operation.responseString,error,operation.response.statusCode,[error domain]);
      
//        [UIAlertView showAlertWithError:error];
        
        block(nil,error);
    }];
    
    
    
    
    [operation start];
}

/**
 
 post 整个response传给去就好了
 
 */
- (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
    
//       NSLog(@"post url # %@",url);
    
    
    AFHTTPRequestOperation *operation = [_clientManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ///处理如果返回200，但是空值的错误
        if (ISEMPTY(responseObject)) {
            NSError *error = [NSError errorWithDomain:kKQErrorDomain code:ErrorClientSuccessNil userInfo:@{NSLocalizedDescriptionKey:[ErrorManager localizedDescriptionForCode: ErrorClientSuccessNil]}];
            
            block(nil,error);
        }
        
        NSDictionary *dict = responseObject;
        
        int code = [dict[@"status"] intValue];
        
        if ([dict[@"status"] intValue] == 1) {
            // 如果status为1，则直接返回data
            block (dict[@"data"],nil);
            
        }
        else{
            
            // 根据status码生成error，传给block
            
            // 查找本地有没有错误对应的msg
            NSString *msg = [ErrorManager localizedDescriptionForCode:code];
            
            //如果本地没有msg，就调用服务器的msg
            if (ISEMPTY(msg)) {
                msg = dict[@"msg"];
            }
            
            
            
            NSError *error = [NSError errorWithDomain:kKQErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:msg}];
            
            block(nil,error);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 如果json不能解析的话
        // AFNetworkingErrorDomain 服务器的404或500错误
        //        NSLog(@"get url %@,response # %@, error # %@,error status code # %d, domain # %@",url, operation.responseString,error,operation.response.statusCode,[error domain]);
        
        //        [UIAlertView showAlertWithError:error];
        
        block(nil,error);
    }];
    
    [operation start];
    
}
//
//- (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
//    
//   
//    
//    
//    AFHTTPRequestOperation *operation = [_clientManager PUT:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
////        NSLog(@"put url # %@, response :%@ %@ ",url, operation.responseString, responseObject);
//        
//        NSDictionary *dict = responseObject;
//        
//        if ([dict[@"status"] intValue] == 1) {
//            block (dict[@"data"],nil);
//        }
//        else{
//            
//            [UIAlertView showAlert:[NSString stringWithFormat:@"状态错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
//            block(nil,nil);
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"put url # %@, error: %@, %@",url, operation.responseString,[error localizedDescription]);
//        [UIAlertView showAlertWithError:error];
//        block(nil,error);
//    }];
//    
//    [operation start];
//    
//}
//
//
//- (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
//    
//    AFHTTPRequestOperation *operation = [_clientManager DELETE:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
////        NSLog(@"delete url # %@,param # %@,response :%@ %@ ",url,parameters, operation.responseString, responseObject);
//        
//        NSDictionary *dict = responseObject;
//        
//        if ([dict[@"status"] intValue] == 1) {
//            block (dict[@"data"],nil);
//        }
//        else{
//            
//            [UIAlertView showAlert:[NSString stringWithFormat:@"错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
//            block(nil,nil);
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"delete url # %@,error: %@, %@", url,operation.responseString,[error localizedDescription]);
//        [UIAlertView showAlertWithError:error];
//        block(nil,error);
//    }];
//    
//    [operation start];
//    
//}
//




#pragma mark - Test

- (void)testEdit{

    NSDictionary *params = @{@"uid":@"131111112",@"password":@"111",@"sessionToken":@"B5rwxTtjvQDiC2FJeHSd",@"nickname":@"bcs"};
    
    [self postWithUrl:api_edit_user_info parameters:params block:^(id object, NSError *error) {
        NSLog(@"object # %@",object);
    }];
}

- (void)testRegister{
    NSDictionary *params = @{@"username":@"bcss",@"password":@"111",@"phone":@"222",@"nickname":@"bcs"};
    
    [self registerWithDict:params block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);

    }];
}

- (void)testLogin{

  
    [self loginWithUsername:@"1358965658" password:@"111" block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
    
}


- (void)testQueryCards{
    [self queryCards:@"539560f2e4b08cd56b62cb98" block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
}


- (void)testUserRest{
 
//    NSString *url = @"http://localhost/kq/index.php/kqapi/user";

      NSString *url = @"http://localhost/kq/index.php/kqapi/user";
    
//    array('objectId'=>array('$in'=>$uids));
    
    NSMutableDictionary *where = [NSMutableDictionary dictionary];
    
    [where setObject:@{@"objectId":@{@"$in":@[@"539676b4e4b09baa2ad7ac78",@"539560f2e4b08cd56b62cb9b"]}} forKey:@"where"];
    
    
//    NSLog(@"where # %@",where);
    [self getWithUrl:url parameters:where block:^(id object, NSError *error) {
//        NSLog(@"user rest obj # %@",object);
        
        
    }];
}


- (void)testSearchCoupon{

    NSDictionary *params = @{@"districtId":@"53956995e4b08cd56b62ec77"};
    
    [self getWithUrl:api_searchCoupons parameters:params block:^(id object, NSError *error) {
        NSLog(@"search obj # %@",object);
    }];
}

- (void)testNewestCoupons{
//    [self getW parameters:<#(NSDictionary *)#> block:<#^(id object, NSError *error)block#>]
}

- (void)test{
    L();
    
//    [self queryUserInfo:@"85" sessionToken:@"eKSBQYduWRG5AI6UHbat" block:^(id object, NSError *error) {
////        NSLog(@"obj # %@",object);
//    }];
    
    
//    [self queryNewestCouponsSkip:0 limit:30 block:^(id object, NSError *error) {
//        NSLog(@"newest coupons # %@",object);
//
//    }];
    
//    [self testSearchCoupon];
//    [self requestCaptchaForgetPassword:@"dsfsdfds" block:^(id object, NSError *error) {
//        NSLog(@"object # %@",object);
//    }];
    
//
//    [self getWithUrl:@"http://115.29.148.47/kq/index.php/kqapi3/newestCoupons" parameters:nil block:^(id object, NSError *error) {
//        NSLog(@"obj # %@",object);
//    }];
    
//    [self testEdit];
    
//    [self testHeader];
    
}

- (void)testHeader{
    NSString *url = @"http://localhost/kq/index.php/kqapi6/test_headers";
    
    [self getWithUrl:url parameters:nil block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
}

- (void)testWithBlock:(BooleanResultBlock)block{

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i<50000; i++) {
            NSLog(@"innerschleife:%d",i);

        }
        
        block(true,nil);
        
    });
    
}
@end
