//
//  UIImageView+Extras.h
//  MyKitchen
//
//  Created by  on 26.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIImage+Extras.h"

@interface UIImageView (Extras)

+ (id)imageViewWithFrame:(CGRect)frame imageName:(NSString*)name;

- (void)setAnimationImageNames:(NSArray *)animationImageNames;

@end
