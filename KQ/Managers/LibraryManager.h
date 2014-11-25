//
//  LibraryManager.h
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"
#import "Coupon.h"

@interface LibraryManager : NSObject{

    MBProgressHUD *_hud;
    UIActivityIndicatorView *_acitvityIndicatorView;
}

@property (nonatomic, strong) NSMutableDictionary *hudCache;

+ (id)sharedInstance;

- (void)shareWithText:(NSString*)text image:(UIImage*)image delegate:(id)delegate;
- (void)shareCoupon:(Coupon*)coupon delegate:(id)delegate;

- (void)startHint:(NSString*)text;
- (void)startHint:(NSString *)text duration:(float)duration;

- (void)startProgress;
- (void)startProgressInView:(UIView *)view;
- (void)hideProgressInView:(UIView*)view;
- (void)dismissProgress;


/**
 *	@brief	当连续多个progess需要显示的时候，用cache方便管理dismiss哪个hud
 *
 *	@param 	key
 */
- (void)startProgress:(NSString*)key;
- (void)dismissProgress:(NSString*)key;


- (void)startLoadingInView:(UIView*)view; //在view上loading，不强制
- (void)stopLoading;

@end
