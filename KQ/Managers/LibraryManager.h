//
//  LibraryManager.h
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"

@interface LibraryManager : NSObject{

    MBProgressHUD *_hud;
}

@property (nonatomic, strong) NSMutableDictionary *hudCache;

+ (id)sharedInstance;

- (void)shareWithText:(NSString*)text image:(UIImage*)image delegate:(id)delegate;



- (void)startHint:(NSString*)text;
- (void)startHint:(NSString *)text duration:(float)duration;

- (void)startProgress;
- (void)dismissProgress;
/**
 *	@brief	当连续多个progess需要显示的时候，用cache方便管理dismiss哪个hud
 *
 *	@param 	key
 */
- (void)startProgress:(NSString*)key;
- (void)dismissProgress:(NSString*)key;

@end
