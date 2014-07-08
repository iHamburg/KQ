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
        case XIncompleteFormFailed:
            str = LString(@"请填写完整表单!");
            break;
        case XNotEnoughEnergy:
            str = LString(@"没有能量了!");
            break;
        case XHasUnlockedLogo:
            str = LString(@"徽章已经收集过了！");
            break;
        case XColdTime:
            str = LString(@"还在冷却时间内,等几分钟再试试吧");
            break;
        default:
            str = LString(@"未知错误");

            break;
    }
    
    return str;
}

+ (void)alertError:(NSError*)error{

    NSString *msg = [ErrorManager localizedDescriptionForCode:error.code];
    if ([msg isEqualToString:LString(@"未知错误")]) {
        msg = [error localizedDescription];
    }
    
    [UIAlertView showAlert:LString(@"错误") msg:msg cancel:LString(@"OK")];
}
@end
