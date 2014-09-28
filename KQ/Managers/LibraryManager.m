//
//  LibraryManager.m
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQRootViewController.h"
#import "LibraryManager.h"
#import "UMSocial.h"

@interface LibraryManager(){
    RootViewController *_root;
}

@end


@implementation LibraryManager

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _root = [KQRootViewController sharedInstance];
        
        _hudCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)shareWithText:(NSString*)text image:(UIImage*)image delegate:(id)delegate{
    
    L();
    
    [UMSocialSnsService presentSnsIconSheetView:delegate
                                         appKey:kUmengAppKey
                                      shareText:text
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms]
                                       delegate:nil];
    
}



- (void)startProgress{
    [self startProgress:@"Default"];
}
- (void)dismissProgress{

    [self dismissProgress:@"Default"];
}

- (void)startProgress:(NSString*)key{
   
    if (ISEMPTY(key)) {
        key = @"Default";
    }
    
    MBProgressHUD *hud = _hudCache[key];

    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:_root.view animated:YES];
        [_hudCache setObject:hud forKey:key];
    }
    else{
        [hud show:YES];
    }
}
- (void)dismissProgress:(NSString*)key{
    if (ISEMPTY(key)) {
        key = @"Default";
    }
    
    MBProgressHUD *hud = [_hudCache objectForKey:key];
//    L();
//    NSLog(@"hud # %@,key # %@",hud,key);
    
    [hud hide:YES];
    
//    [_hudCache removeObjectForKey:key];
}

- (void)startHint:(NSString*)text{

    [self startHint:text duration:1];
    
}

- (void)startHint:(NSString *)text duration:(float)duration{

    MBProgressHUD *hud = _hudCache[@"DefaultHint"];
    
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:_root.view animated:YES];
        [_hudCache setObject:hud forKey:@"DefaultHint"];
    }
    else{
        [hud show:YES];
    }
    
//    _hud = [MBProgressHUD showHUDAddedTo:_root.view animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    
    [hud hide:YES afterDelay:duration];

}
@end
