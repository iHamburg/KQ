//
//  ErrorManager.h
//  GSMA
//
//  Created by AppDevelopper on 14-5-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#define CustomErrorDomain @"de.xappsoft.dsma"

typedef enum {
    UnknownFailed = -1000,
    XRegisterFailed,
    XConnectFailed,
    XNotBindedFailed = 4498,
    XNotEnoughEnergy = 4499,
    XHasUnlockedLogo = 4500,
    XColdTime = 4501,
    XIncompleteFormFailed
    
}CustomErrorCode;


@interface ErrorManager : NSObject

+ (NSString*)localizedDescriptionForCode:(CustomErrorCode)code;

+ (void)alertError:(NSError*)error;

@end
