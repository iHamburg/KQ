//
//  User.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "User.h"

@implementation User


+ (User*)user{
    
    User *user = [[User alloc] init];
    
    user.username = @"测试用户";
    
    return user;
}

@end
