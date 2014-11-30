//
//  AutoHeightCell.h
//  KQ
//
//  Created by Forest on 14-11-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigCell.h"

@interface AutoHeightCell : ConfigCell

+ (CGFloat)cellHeightWithString:(NSString*)text font:(UIFont*)font;

@end
