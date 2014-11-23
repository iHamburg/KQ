//
//  UIView+Extras.h
//  XappCard
//
//  Created by  on 27.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Extras)



+ (id)viewWithNibName:(NSString*)name;

- (UIView*)addInsideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity;

- (void)resetAnchorPoint;

- (void)fadeIn;
- (void)fadeOut;
+ (void)fadeIn:(NSArray*)views withDuration:(CGFloat)duration;
+ (void)fadeOut:(NSArray*)views withDuration:(CGFloat)duration;
- (void)slideInSuperview:(UIView*)aSuperView;
- (void)slideOut;

- (void)applyShadow;
- (void)applyGradientBorder:(unsigned int)edges indent:(CGFloat)indent;
- (void)applyShadowBorder:(unsigned int)edges withColor:(UIColor*)color indent:(CGFloat)indent;
- (void)applyBorder:(unsigned int)edges indent:(CGFloat)indent;


- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)original;
- (void)setFrameCenter:(CGPoint)frameCenter;

- (void)moveOrigin:(CGPoint)relativePoint;

- (CGFloat)width;
- (CGFloat)height;
- (CGSize)size;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;



+ (CGSize)sizeForImage:(UIImage*)image withMinSide:(CGFloat)minSide;

- (void)removeAllSubviews;
- (void)setBGView:(NSString*)imgName;


//- (void)addTapGesture:(SEL)action;

/**
 旋转一圈
 */
- (void)rotate;
- (void)rotateWithCount:(int)count;

//
- (void)addBottomLine:(UIColor*)color;
- (void)addBottomDottedLine;
@end
