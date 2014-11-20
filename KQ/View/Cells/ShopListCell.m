//
//  ShopListCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-6.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ShopListCell.h"
#import "UIImageView+WebCache.h"

@implementation ShopListCell

- (void)setValue:(Shop*)shop{

    _value = shop;
    
    self.firstLabel.text = shop.title;
    
    [self.avatarV setImageWithURL:[NSURL URLWithString:shop.logoUrl] placeholderImage:DefaultImg];

//    self.firstLabel.backgroundColor = [UIColor redColor];
    
}

- (void)load{

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.avatarV.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarV.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}

@end
