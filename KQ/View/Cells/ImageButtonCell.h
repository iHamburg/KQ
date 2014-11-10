//
//  ImageButtonCell.h
//  KQ
//
//  Created by AppDevelopper on 14-6-23.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ButtonCell.h"

// 左边是图片的button
@interface ImageButtonCell : ButtonCell{
    UIImageView *_bgV;
}

@property (nonatomic, strong) UIImageView *bgV;
@end
