//
//  ErrorManager.h
//  GSMA
//
//  Created by AppDevelopper on 14-5-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#define kKQErrorDomain @"KQ"


typedef enum {
   
    // 服务器端的错误
    ErrorEmptyParameter = 400,
    
    ErrorEmptyUsernamePwd = 401,
    
    ErrorEmptyUid = 403,
    
    ErrorEmptyCard = 404,// 卡号为空【请填写卡号】
    
    ErrorEmptyCouponId = 405,// 快券Id为空【无此优惠券】
    
     ErrorEmptySession = 406,// Session为空【请重新登录】
    
     ErrorEmptyShopId = 407,// ShopId为空【无此店铺】
    
     ErrorEmptyUnionCouponId = 408,// 优惠券的银联编号为空【无此优惠券】
    
     ErrorEmptyUnionUid = 409,// 用户的银联编号为空【用户不存在】
    
     ErrorInvalidUsernamePwd = 601,// 用户名或密码错误【您的用户名或密码不正确】
    
     ErrorInvalidUsername = 602,// 无效的用户名【用户名不存在】
    
     ErrorInvalidCouponId = 603,// 无效的快券【无此优惠券】
    
     ErrorInvalidSession = 604,// 无效的Session【请重新登录】
    
     ErrorInvalidPassword = 605,// 旧密码错误【旧密码不对哦~】
    
     ErrorDBUpdate = 701,// 数据库更新错误【好像什么地方出了问题哒~】
    
     ErrorDBDelete = 702,// 数据库删除错误【好像什么地方出了问题哒~】
    
     ErrorDBInsert = 703,// 数据库插入错误【好像什么地方出了问题哒~】
    
     ErrorFailureSMS = 801,// 短信发送错误【短信发送失败】
    
     ErrorLimitDCoupon = 802,// 用户不能下载该快券【已到达下载券的数量上限】
    
     ErrorFailureDCoupon = 803,// 用户下载快券失败【无法下载该优惠券】
    
     ErrorUsernameExists = 1001,// 用户名已存在【用户名已存在】
    
     ErrorCardExists = 1003,// 用户已经绑定该银行卡【银行卡已被绑定过啦】
    
    
     // 银联服务器的错误
     ErrorUnionInvalidCard = 300500,// 卡号无效【无效的卡号】
    
     ErrorUnionExistCard = 300519,// 重复绑卡【请不要重复绑卡】
    
     ErrorUnionLimitCardNumber = 300520,// 超过最大开通钱包服务的卡的数量【到达上限，不能再绑定银行卡了哦~】
    
     ErrorUnionUnknown = 300000,// 未知银联错误【好像什么地方出了问题哒~】
    
     ErrorUnionInvalidCoupon = 500046,// 银联优惠券无效【无此优惠券】
    
     ErrorUnionInvalidParameter = 300002,// 银联参数值无效【好像什么地方出了问题哒~】
    
     ErrorUnionEmptyUser = 300200,// 银联用户不存在【该用户不存在】
    
     ErrorUnionGetUser = 900,// 银联查询用户错误【该用户不存在】
    
     ErrorUnionRegister = 901,// 银联注册用户错误【该用户不存在】
    
     ErrorUnionBindCard = 902,// 银联绑卡错误【绑定银行卡失败】
    
     ErrorUnionUnbindCard = 903,// 银联解卡错误【解除绑定失败】
    
     ErrorUnionDownloadCoupon = 904,// 银联下载快券错误【无法下载该优惠券】
    
    ErrorUnionDCouponLimt = 500048,
   
    ErrorUnionNoCardBunden = 500058,
    
    //客户端连接的错误
    ErrorClientSuccessNil = 2001,

    
    //内部错误
    ErrorAppPasswordInConsistent = 2100,  //输入密码不一致

    ErrorAppInvalidCaptcha = 2101,   //验证码不正确
    
    ErrorAppEmptyParameter = 2002,   //输入信息不完整
    
    ErrorAppInvalideCard = 2003,   //无效的银联卡号
    
    ErrorUnknown = 999999
    
}CustomErrorCode;


@interface ErrorManager : NSObject

+ (NSString*)localizedDescriptionForCode:(CustomErrorCode)code;

+ (void)alertError:(NSError*)error;


@end
