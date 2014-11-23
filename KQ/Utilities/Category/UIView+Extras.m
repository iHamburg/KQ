//
//  UIView+Extras.m
//  XappCard
//
//  Created by  on 27.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import "UIView+Extras.h"
#import <QuartzCore/QuartzCore.h>
#import "Macros.h"
#import "UIImage+Extras.h"

#define kTagBGV 789

@implementation UIView (Extras)



+ (id)viewWithNibName:(NSString*)name{
	NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
	return [bundle objectAtIndex:0];
}


- (void)setImage:(UIImage *)image{
}


- (void)fadeIn {
	if (self.alpha == 1.0) {
		return;
	}
	
	[UIView beginAnimations:@"fadeIn" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	self.alpha = 1.0;
	
	[UIView commitAnimations];
}

- (void)fadeOut {
	if (self.alpha == 0.0) {
		return;
	}
	
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	self.alpha = 0.0;
	
	[UIView commitAnimations];
}


- (void)slideInSuperview:(UIView*)aSuperView{
	[self setOrigin:CGPointMake(aSuperView.width, 0)];
	[aSuperView addSubview:self];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[self moveOrigin:CGPointMake(-self.width, 0)];
	[UIView commitAnimations];
}
- (void)slideOut{
	[UIView animateWithDuration:0.3 animations:^{
		[self setOrigin:CGPointMake(self.width, 0)];
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

+ (void)fadeIn:(NSArray*)views withDuration:(CGFloat)duration {
	[UIView beginAnimations:@"fadeIn" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	for (UIView* view in views) {
		[view setAlpha:1.0f];
	}
	[UIView commitAnimations];
}

+ (void)fadeOut:(NSArray*)views withDuration:(CGFloat)duration {
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	for (UIView* view in views) {
		[view setAlpha:0.0f];
	}
	[UIView commitAnimations];
}


- (UIView*)addInsideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    CGRect shadowFrame; // Modify this if needed
    shadowFrame.size.width = 0.f;
    shadowFrame.size.height = 0.f;
    shadowFrame.origin.x = 0.f;
    shadowFrame.origin.y = 0.f;
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    shadow.userInteractionEnabled = NO; // Modify this if needed
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    [self.superview insertSubview:shadow belowSubview:self];
    [shadow addSubview:self];
    
    return shadow;
}

#pragma mark - Size
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)original{
	CGRect frame = self.frame;
	frame.origin = original;
	self.frame = frame;
}

- (void)setFrameCenter:(CGPoint)frameCenter{
	
	CGSize size = self.frame.size;
	self.frame = CGRectMake(frameCenter.x-size.width/2, frameCenter.y - size.height/2, size.width, size.height);

}

- (void)moveOrigin:(CGPoint)relativePoint{
	CGRect frame = self.frame;
	CGPoint origin = frame.origin;
	origin.x+=relativePoint.x;
	origin.y+=relativePoint.y;
	frame.origin = origin;
	self.frame = frame;
}

- (CGFloat)width{
	
	return self.bounds.size.width;

}
- (CGFloat)height{
	return self.bounds.size.height;
}

- (CGSize)size{
    return self.bounds.size;
}
- (void)setWidth:(CGFloat)width{
	CGRect frame = self.frame;
	frame.size = CGSizeMake(width, self.height);
	
	self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
	
	CGRect frame = self.frame;
	frame.size = CGSizeMake(self.width, height);
	self.frame = frame;
}

+ (CGSize)sizeForImage:(UIImage*)image withMinSide:(CGFloat)minSide{
	CGFloat width = image.size.width;
	CGFloat height = image.size.height;
	CGSize size;
	//	CGFloat minSide = 320;
	
	if (width>height) {
		size = CGSizeMake( width/height*minSide, minSide);
	}
	else{
		size = CGSizeMake( minSide, height/width*minSide);
	}
	return size;
}

#pragma mark - Gradient

- (void)applyShadow{
	self.layer.shadowColor = [UIColor colorWithWhite:0.4 alpha:0.8].CGColor;
	self.layer.shadowOpacity = 1;
	self.layer.shadowOffset = isPad?CGSizeMake(2, 2):CGSizeMake(1, 1);
	self.layer.shouldRasterize = YES;
}


- (void)applyGradientBorder:(unsigned int)edges indent:(CGFloat)indent {
	
	//apply gradient mask
	CALayer* maskLayer = [CALayer layer];
	CGRect frame = self.bounds;
	
	maskLayer.frame = frame;
	
	if (self.layer.borderWidth && self.layer.borderColor) {
		frame = CGRectInset(frame, self.layer.borderWidth, self.layer.borderWidth);
	}
	
	if (edges & kCALayerTopEdge) {
		CAGradientLayer* topGradientLayer = [CAGradientLayer layer];
		topGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), indent);
		
		topGradientLayer.colors = [NSArray arrayWithObjects:
								   (id)[[UIColor clearColor] CGColor],
								   (id)[[UIColor blackColor] CGColor],
								   nil];
		topGradientLayer.startPoint = CGPointMake(0.5,0.0);
		topGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[maskLayer addSublayer:topGradientLayer];
		
		frame.origin.y = indent;
		frame.size.height -= indent;
	}
	
	if (edges & kCALayerBottomEdge) {
		CAGradientLayer* bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - indent, CGRectGetWidth(frame), indent);
		
		bottomGradientLayer.colors = [NSArray arrayWithObjects:
									  (id)[[UIColor blackColor] CGColor],
									  (id)[[UIColor clearColor] CGColor],
									  nil];
		
		bottomGradientLayer.startPoint = CGPointMake(0.5,0.0);
		bottomGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[maskLayer addSublayer:bottomGradientLayer];
		
		frame.size.height -= indent;
	}
	
	if (edges & kCALayerLeftEdge) {
		CAGradientLayer* leftGradientLayer = [CAGradientLayer layer];
		leftGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		leftGradientLayer.colors = [NSArray arrayWithObjects:
									(id)[[UIColor clearColor] CGColor],
									(id)[[UIColor blackColor] CGColor],
									nil];
		
		leftGradientLayer.startPoint = CGPointMake(0.0,0.5);
		leftGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:leftGradientLayer];
		
		frame.origin.x = indent;
		frame.size.width -= indent;
	}
	
	if (edges & kCALayerRightEdge) {
		CAGradientLayer* rightGradientLayer = [CAGradientLayer layer];
		rightGradientLayer.frame = CGRectMake(CGRectGetMaxX(frame) - indent, CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		rightGradientLayer.colors = [NSArray arrayWithObjects:
									 (id)[[UIColor blackColor] CGColor],
									 (id)[[UIColor clearColor] CGColor],
									 nil];
		
		rightGradientLayer.startPoint = CGPointMake(0.0,0.5);
		rightGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:rightGradientLayer];
		
		frame.size.width -= indent;
	}
	
	//at least the middle
	CALayer* middleLayer = [CALayer layer];
	middleLayer.backgroundColor = [UIColor blackColor].CGColor;
	middleLayer.frame = frame;
	[maskLayer addSublayer:middleLayer];
	
	if (self.layer.borderWidth && self.layer.borderColor) {
		CALayer* borderLayer = [CALayer layer];
		borderLayer.frame = self.bounds;
		borderLayer.borderColor = self.layer.borderColor;
		borderLayer.borderWidth = self.layer.borderWidth;
		[maskLayer addSublayer:borderLayer];
	}
	
	self.layer.mask = maskLayer;
}

- (void)applyShadowBorder:(unsigned int)edges withColor:(UIColor*)color indent:(CGFloat)indent {
	UIColor* shadowColor = (color)? color: [UIColor blackColor];
	CGRect frame = self.bounds;
	
	if (edges & kCALayerTopEdge) {
		CAGradientLayer* topGradientLayer = [CAGradientLayer layer];
		topGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), indent);
		
		topGradientLayer.colors = [NSArray arrayWithObjects:
								   (id)shadowColor.CGColor,
								   (id)[[UIColor clearColor] CGColor],
								   nil];
		topGradientLayer.startPoint = CGPointMake(0.5,0.0);
		topGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[self.layer addSublayer:topGradientLayer];
	}
	
	if (edges & kCALayerBottomEdge) {
		CAGradientLayer* bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - indent, CGRectGetWidth(frame), indent);
		
		bottomGradientLayer.colors = [NSArray arrayWithObjects:
									  (id)[[UIColor clearColor] CGColor],
									  (id)shadowColor.CGColor,
									  nil];
		
		bottomGradientLayer.startPoint = CGPointMake(0.5,0.0);
		bottomGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[self.layer addSublayer:bottomGradientLayer];
	}
	
	if (edges & kCALayerLeftEdge) {
		CAGradientLayer* leftGradientLayer = [CAGradientLayer layer];
		leftGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		leftGradientLayer.colors = [NSArray arrayWithObjects:
									(id)shadowColor.CGColor,
									(id)[[UIColor clearColor] CGColor],
									nil];
		
		leftGradientLayer.startPoint = CGPointMake(0.0,0.5);
		leftGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[self.layer addSublayer:leftGradientLayer];
	}
	
	if (edges & kCALayerRightEdge) {
		CAGradientLayer* rightGradientLayer = [CAGradientLayer layer];
		rightGradientLayer.frame = CGRectMake(CGRectGetMaxX(frame) - indent, CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		rightGradientLayer.colors = [NSArray arrayWithObjects:
									 (id)[[UIColor clearColor] CGColor],
									 (id)shadowColor.CGColor,
									 nil];
		
		rightGradientLayer.startPoint = CGPointMake(0.0,0.5);
		rightGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[self.layer addSublayer:rightGradientLayer];
	}
}


- (void)applyBorder:(unsigned int)edges indent:(CGFloat)indent {
	
	//apply gradient mask
	CALayer* maskLayer = [CALayer layer];
	CGRect frame = self.bounds;
	
//	maskLayer.frame = frame;
	
//	if (self.layer.borderWidth && self.layer.borderColor) {
//		frame = CGRectInset(frame, self.layer.borderWidth, self.layer.borderWidth);
//	}
//	
	if (edges & kCALayerTopEdge) {
        
        maskLayer.backgroundColor = self.layer.borderColor;
        maskLayer.frame = CGRectMake(0, 0, self.width, indent);
        
//		CAGradientLayer* topGradientLayer = [CAGradientLayer layer];
//		topGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), indent);
//		
//		topGradientLayer.colors = [NSArray arrayWithObjects:
//								   (id)[[UIColor clearColor] CGColor],
//								   (id)[[UIColor blackColor] CGColor],
//								   nil];
//		topGradientLayer.startPoint = CGPointMake(0.5,0.0);
//		topGradientLayer.endPoint = CGPointMake(0.5,1.0);
//        CALayer *layer = [CALayer layer];
//        layer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), 5);
//        layer.backgroundColor = [UIColor blackColor].CGColor;
//        maskLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), 5)
//        [maskLayer addSublayer:layer];
		
//		frame.origin.y = indent;
//		frame.size.height -= indent;
	}
	
	if (edges & kCALayerBottomEdge) {
		CAGradientLayer* bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame) - indent, CGRectGetWidth(frame), indent);
		
		bottomGradientLayer.colors = [NSArray arrayWithObjects:
									  (id)[[UIColor blackColor] CGColor],
									  (id)[[UIColor clearColor] CGColor],
									  nil];
		
		bottomGradientLayer.startPoint = CGPointMake(0.5,0.0);
		bottomGradientLayer.endPoint = CGPointMake(0.5,1.0);
		[maskLayer addSublayer:bottomGradientLayer];
		
		frame.size.height -= indent;
	}
	
	if (edges & kCALayerLeftEdge) {
		CAGradientLayer* leftGradientLayer = [CAGradientLayer layer];
		leftGradientLayer.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		leftGradientLayer.colors = [NSArray arrayWithObjects:
									(id)[[UIColor clearColor] CGColor],
									(id)[[UIColor blackColor] CGColor],
									nil];
		
		leftGradientLayer.startPoint = CGPointMake(0.0,0.5);
		leftGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:leftGradientLayer];
		
		frame.origin.x = indent;
		frame.size.width -= indent;
	}
	
	if (edges & kCALayerRightEdge) {
		CAGradientLayer* rightGradientLayer = [CAGradientLayer layer];
		rightGradientLayer.frame = CGRectMake(CGRectGetMaxX(frame) - indent, CGRectGetMinY(frame), indent, CGRectGetHeight(frame));
		
		rightGradientLayer.colors = [NSArray arrayWithObjects:
									 (id)[[UIColor blackColor] CGColor],
									 (id)[[UIColor clearColor] CGColor],
									 nil];
		
		rightGradientLayer.startPoint = CGPointMake(0.0,0.5);
		rightGradientLayer.endPoint = CGPointMake(1.0,0.5);
		[maskLayer addSublayer:rightGradientLayer];
		
		frame.size.width -= indent;
	}
	
//	//at least the middle
//	CALayer* middleLayer = [CALayer layer];
//	middleLayer.backgroundColor = [UIColor blackColor].CGColor;
//	middleLayer.frame = frame;
//	[maskLayer addSublayer:middleLayer];
//	
//	if (self.layer.borderWidth && self.layer.borderColor) {
//		CALayer* borderLayer = [CALayer layer];
//		borderLayer.frame = self.bounds;
//		borderLayer.borderColor = self.layer.borderColor;
//		borderLayer.borderWidth = self.layer.borderWidth;
//		[maskLayer addSublayer:borderLayer];
//	}
	
//	self.layer.mask = maskLayer;
    [self.layer addSublayer:maskLayer];
}


#pragma mark -
- (void)removeAllSubviews{
	NSArray *subviews = self.subviews;
	for (UIView *v in subviews) {
		[v removeFromSuperview];
	}
}

- (void)setBGView:(NSString*)imgName{
	UIImageView *bgV = [[UIImageView alloc]initWithFrame:self.bounds];
	bgV.image = [UIImage imageWithContentsOfFileUniversal:imgName];
	bgV.tag = kTagBGV;
	bgV.autoresizingMask = kAutoResize;
	[self addSubview:bgV];
}

- (void)resetAnchorPoint{
    
    if (self.superview) {
        CGPoint locationInSuperview = [self convertPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) toView:[self superview]];
        [[self layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
        [self setCenter:locationInSuperview];
    }
	
}

#pragma mark - Animation
- (void)rotate{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 ];
    rotationAnimation.duration = 0.4;
    rotationAnimation.cumulative = YES;
    //    rotationAnimation.repeatCount = repeat;
    //
    //    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    scaleAnimation.toValue = [NSNumber numberWithFloat:1.1];
    //    scaleAnimation.duration = duration/2;
    //    scaleAnimation.autoreverses = YES;
    //    scaleAnimation.repeatCount = 1;
    //
    //    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    //    group.animations = [NSArray arrayWithObjects:rotationAnimation,scaleAnimation, nil];
    //
    //    //这里的时间一定要加，否则group的时间不对
    //    group.duration = duration;
    
    //    [view.layer addAnimation:group forKey:@"group"];
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

- (void)rotateWithCount:(int)count{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1 ];
    rotationAnimation.duration = 0.4;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = count;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotation"];

}

#pragma mark -

- (void)addBottomLine:(UIColor*)color{
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, self.width, 1)];
            v.backgroundColor = color;
            [self addSubview:v];

}
- (void)addBottomDottedLine{
    UIImageView *separatorV = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 1)];
    separatorV.image = [UIImage imageNamed:@"bg_虚线.png"];
    [self addSubview:separatorV];

}
@end
