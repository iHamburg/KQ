//
//  ErrorManager.m
//  GSMA
//
//  Created by AppDevelopper on 14-5-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ErrorManager.h"

@implementation ErrorManager

+ (NSString*)localizedDescriptionForCode:(CustomErrorCode)code{

    NSString *str;
    
    switch (code) {
        case ErrorEmptyParameter:
        
            str = @"传入的参数不完整";
            break;
        case ErrorClientSuccessNil:
            str = @"服务器没有返回值";
        default:
            str = @"";

        break;
    }
    
    return str;
}

+ (void)alertError:(NSError*)error{

//    NSString *msg = [ErrorManager localizedDescriptionForCode:(CustomErrorCode)error.code];
//    if ([msg isEqualToString:LString(@"未知错误")]) {
//        msg = [error localizedDescription];
//    }
//    
//    [UIAlertView showAlert:LString(@"错误") msg:msg cancel:LString(@"OK")];

    int code = error.code;
    NSString *msg = error.localizedDescription;
    //                    NSLog(@"code # %d, msg # %@",code,msg);
    
    // 其他的错误就显示给用户
    [UIAlertView showAlert:[NSString stringWithFormat:@"错误: %d",code] msg:msg];


}
@end
