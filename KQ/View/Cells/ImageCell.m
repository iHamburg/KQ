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

- (void)load{
    
    [super load];

}

- (void)layoutSubviews{
    
    //默认组件的frame只能在layoutSubviews中设定. 或者可以在load中确定具体的size
    self.imageView.frame = self.bounds;
}

@end
