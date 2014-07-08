//
//  ImageCell.m
//  Makers
//
//  Created by AppDevelopper on 14-6-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell


- (void)setValue:(UIImage*)image{

    self.imageView.image = image;

}

- (void)layoutSubviews{
    
    self.imageView.frame = self.bounds;
}

@end
