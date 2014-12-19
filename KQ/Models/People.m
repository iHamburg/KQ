//
//  People.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "People.h"

@implementation People

static NSArray *keys;

+ (void)initialize {
    if (self == [People self]) {
        // ... do the initialization ...

        keys = @[@"id",@"username",@"password",@"sessionToken",@"avatarUrl",@"nickname"];
    }
}


- (void)setNewsNum:(int)newsNum{
    
    _newsNum = newsNum;
    
    
}

- (id)init{
    
    if (self = [super init]) {
        self.isNotification = YES;
    }
    
    return self;
}


- (id)initWithDict:(NSDictionary*)dict{
    if (self = [self init]) {
        
        NSLog(@"dict # %@",dict);
     
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dict = [dict dictionaryCheckNull];
        }
        else{
            return self;
        }
        
        self.id = dict[@"id"];
        self.username = dict[@"username"];
        self.avatarUrl = dict[@"avatarUrl"];
        self.nickname = dict[@"nickname"];
        self.sessionToken = dict[@"sessionToken"];
        self.isNotification = YES;
   

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    
    for (NSString *key in keys) {
//        NSLog(@"key # %@, value # %@",key,[aDecoder decodeObjectForKey:key]);
        
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
    }
    
    self.lastNewsId = [aDecoder decodeIntForKey:@"lastNewsId"];
    self.isNotification = [aDecoder decodeBoolForKey:@"isNotification"];
    
    if (self.isNotification != false) {
        self.isNotification = YES;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{

    for (NSString *key in keys) {
//          NSLog(@"key # %@, value # %@",key,[self valueForKey:key]);
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    
    [aCoder encodeInt:self.lastNewsId forKey:@"lastNewsId"];
    [aCoder encodeBool:self.isNotification forKey:@"isNotification"];

//    L();
//    NSLog(@"people.lastNewsId # %d",self.lastNewsId);
}


@end
