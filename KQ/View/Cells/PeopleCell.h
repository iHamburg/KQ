//
//  UserCell.h
//  Makers
//
//  Created by AppDevelopper on 14-5-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigCell.h"
#import "People.h"
@interface PeopleCell : ConfigCell{
    People *_people;
}


@property (nonatomic, strong) People *people;
@end
