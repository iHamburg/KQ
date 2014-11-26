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
        
        _acitvityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

        _acitvityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        

    }
    return self;
}

- (void)shareWithText:(NSString*)text image:(UIImage*)image delegate:(id)delegate{
    
    L();
    
    [UMSocialSnsService presentSnsIconSheetView:delegate
                                         appKey:kUmengAppKey
                                      shareText:text
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms]
                                       delegate:nil];
    
}

- (void)shareCoupon:(Coupon*)coupon delegate:(id)delegate{
    
    NSString *title = coupon.title;
    NSString *discountContent = coupon.discountContent;
    NSString *advertise = @"试试快券吧，再也不用带着团购验证码逛街了！更多详情 http://www.quickquan.com";
    NSString *short_desc = coupon.short_desc;
    
    NSString *sinaText = [NSString stringWithFormat:@"【%@%@】%@%@",title,discountContent,advertise,short_desc];
     [UMSocialData defaultData].extConfig.sinaData.shareText = sinaText;
    
    //weixin:  [多商圈]摩提工房 立减5元
    NSString *weixinText = [NSString stringWithFormat:@"【多商圈】%@%@",title,discountContent];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = weixinText;
    
    //朋友圈：摩提工房 立减5元
    NSString *wechatTimeline = [NSString stringWithFormat:@"【多商圈】%@%@",title,discountContent];
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = wechatTimeline;
    
    //短信：【摩提工房立减五元】+advertise
    NSString *smsText = [NSString stringWithFormat:@"【%@%@】%@",title,discountContent,advertise];
    [UMSocialData defaultData].extConfig.smsData.shareText = smsText;
  
    //email : sinaText
    [UMSocialData defaultData].extConfig.emailData.shareText = sinaText;
    
    //QQ: 【多商圈】 摩提工房 立减5元
    [UMSocialData defaultData].extConfig.qqData.shareText = [NSString stringWithFormat:@"【多商圈】%@%@",title,discountContent];

    
    //QZone 【摩提工房立减5元】 + short_desc
    [UMSocialData defaultData].extConfig.qzoneData.shareText = [NSString stringWithFormat:@"【%@%@】%@",title,discountContent,short_desc];


    
    
    [UMSocialSnsService presentSnsIconSheetView:delegate
                                         appKey:kUmengAppKey
                                      shareText:sinaText
                                     shareImage:coupon.avatar
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms]
                                       delegate:delegate];

    
}


- (void)startProgress{
    [self startProgress:@"Default"];
}
- (void)dismissProgress{

    [self dismissProgress:@"Default"];
}

- (void)startProgressInView:(UIView *)view{
  
    
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
   
    [hud show:YES];
   

}


- (void)hideProgressInView:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
- (void)startProgress:(NSString*)key{
   
    if (ISEMPTY(key)) {
        key = @"Default";
    }
    
    MBProgressHUD *hud = _hudCache[key];

    if (!hud) {
        UIView *view = [[[UIApplication sharedApplication] windows] firstObject];
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
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
    [hud hide:YES];
    
//    [_hudCache removeObjectForKey:key];
}

- (void)startHint:(NSString*)text{

    [self startHint:text duration:1];
    
}

- (void)startHint:(NSString *)text duration:(float)duration{

    MBProgressHUD *hud = _hudCache[@"DefaultHint"];
    
    if (!hud) {
        UIView *view = [[[UIApplication sharedApplication] windows] firstObject];
         hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        hud = [MBProgressHUD showHUDAddedTo:_root.view animated:YES];
        [_hudCache setObject:hud forKey:@"DefaultHint"];
    }
    else{
        [hud show:YES];
    }
    
    hud.labelText = text;
//    hud.detailsLabelText = @"details";
    hud.mode = MBProgressHUDModeText;
    
    [hud hide:YES afterDelay:duration];

}


- (void)startLoadingInView:(UIView*)view{
    
    _acitvityIndicatorView.frame = view.bounds;
//    _acitvityIndicatorView.backgroundColor = [UIColor redColor];
    
    [view addSubview:_acitvityIndicatorView];
    
    [_acitvityIndicatorView startAnimating];
}
- (void)stopLoading{
    
    [_acitvityIndicatorView stopAnimating];
    [_acitvityIndicatorView removeFromSuperview];
}
@end
