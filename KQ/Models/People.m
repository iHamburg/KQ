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
    
    NSLog(@"newsNum # %d",newsNum);
    
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
    
//        NSLog(@"people.lastNewsId # %d",self.lastNewsId);
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{

    for (NSString *key in keys) {
//          NSLog(@"key # %@, value # %@",key,[self valueForKey:key]);
        
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    
    [aCoder encodeInt:self.lastNewsId forKey:@"lastNewsId"];

//    L();
//    NSLog(@"people.lastNewsId # %d",self.lastNewsId);
}


@end
