//
//  UIImageView+Extras.m
//  MyKitchen
//
//  Created by  on 26.07.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "UIImageView+Extras.h"

@implementation UIImageView (Extras)

- (void)setAnimationImageNames:(NSArray *)animationImageNames{
	NSMutableArray *imgs = [NSMutableArray array];
	for (NSString *imgName in animationImageNames) {
		UIImage *img = [UIImage imageWithContentsOfFileUniversal:imgName];
		[imgs addObject:img];
	}
	self.animationImages = imgs;
	
}

+ (id)imageViewWithFrame:(CGRect)frame imageName:(NSString*)name{

    UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
    v.image = [UIImage imageNamed:name];
    return v;
}
@end
