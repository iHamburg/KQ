//
//  ErrorManager.m
//  GSMA
//
//  Created by AppDevelopper on 14-5-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ErrorManager.h"
#import "LibraryManager.h"

@implementation ErrorManager

+ (NSString*)localizedDescriptionForCode:(CustomErrorCode)code{

    NSString *str;
    
    switch (code) {
        case ErrorEmptyParameter:
        
            str = @"传入的参数不完整";
        break;
        case ErrorClientSuccessNil:
            str = @"服务器没有返回值";
        
            break;
        case ErrorAppPasswordInConsistent:
            
            str = @"密码输入不一致";
            break;
        case ErrorAppInvalidCaptcha:
            
            str = @"验证码错误";
            break;
        case ErrorAppEmptyParameter:
            
            str = @"请完整输入所有信息";
            break;
        case ErrorAppInvalideCard:
            
            str = @"请输入以62开头的13到19位银行卡号";
            break;
        case ErrorAppInvalide62Card:
            str = @"限添加卡号62开头的银行卡";
            break;
        case ErrorAppUnselected:
            str = @"请先阅读并同意协议";
            break;
        default:
            str = @"";

        break;
    }
    
    return str;
}

+ (void)alertError:(NSError*)error{

//    int code = error.code;
    NSString *msg = error.localizedDescription;
    
    // 其他的错误就显示给用户

//    [[LibraryManager sharedInstance] startHint:[NSString stringWithFormat:@"%@ (%d)",msg,code]];
    
        [[LibraryManager sharedInstance] startHint:[NSString stringWithFormat:@"%@",msg]];
}
@end
