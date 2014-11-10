//
//  Card.m
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        
    }
    
    return self;
}

+ (id)cardWithDict:(NSDictionary*)dict{
    Card *card = [Card new];


    dict = [dict dictionaryCheckNull];
    
    card.id = dict[@"objectId"];
    card.bankId = dict[@"bank"][@"objectId"];
    card.bankName = dict[@"bank"][@"title"];
    card.peopleId = dict[@"people"][@"objectId"];
    card.title = dict[@"title"];

    return card;
}

@end
