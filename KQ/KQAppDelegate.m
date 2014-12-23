//
//  KQAppDelegate.m
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "KQAppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "KQRootViewController.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "MobClick.h"

#define kWeixinAppId @"wxe65e25809040a5bb"
#define kWeixinAppSecret @"7e49bb0130145071b7fa9ede711c4660"
#define kShareUrl @"http://www.quickquan.com/app/share.php"
#define kQQAppKey @"1103359890"
#define kQQAppSecret @"5OsrrE4MdSuOfKzc"

@implementation KQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initUmeng];
    
    [self customizeAppearance];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    
    
//	self.window.rootViewController = [KQRootViewController sharedInstance];
    
    
    
    return YES;
}

- (void)initUmeng
{
    // 友盟
    [UMSocialData setAppKey:kUmengAppKey];
    [UMSocialWechatHandler setWXAppId:kWeixinAppId appSecret:kWeixinAppSecret url:kShareUrl];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.quickquan.com"];
    [UMSocialQQHandler setQQWithAppId:kQQAppKey appKey:kQQAppSecret url:kShareUrl];
    
//    [UMSocialData defaultData].extConfig.sinaData.shareText = @"分享到新浪微博内容";
//    [UMSocialData defaultData].extConfig.tencentData.shareImage = [UIImage imageNamed:@"icon"]; //分享到腾讯微博图片
//    [[UMSocialData defaultData].extConfig.wechatSessionData.urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];  //设置微信好友分享url图片
//    [[UMSocialData defaultData].extConfig.wechatTimelineData.urlResource setResourceType:UMSocialUrlResourceTypeVideo url:@"http://v.youku.com/v_show/id_XNjQ1NjczNzEy.html?f=21207816&ev=2"]; //设置微信朋友圈分享视频
    
    
    [MobClick startWithAppkey:kUmengAppKey reportPolicy:BATCH   channelId:@""];
    
    [MobClick setLogEnabled:YES];
    [MobClick updateOnlineConfig];
//    [MobClick setCrashReportEnabled:NO];
 
}


- (void)customizeAppearance{

   
///     取消navibar下方的阴影线
///    不能简单用44的图片来替换！，可能64可以？  不能使用的原因是：使用后storyboard中push出来的VC的navibar永远是白色的，不能调！！
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"]
//                                      forBarPosition:UIBarPositionAny
//                                         barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];  //

    [[UINavigationBar appearance] setBarTintColor:kColorYellow];  //背景色
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; //title文字颜色
    
    // Title文字
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:18]}];
    
    // --- Segement
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : kColorDardGray,
                                                              NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor whiteColor],
                                                            NSFontAttributeName:[UIFont fontWithName:kFontBoldName size:13]
                                                              } forState:UIControlStateHighlighted];

    // SegmentTitle文件颜色
    [[UISegmentedControl appearance] setTintColor:kColorLightYellow];
    
    
    // Alert

    

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

void uncaughtExceptionHandler(NSException *exception) {

    NSLog(@"exception # %@",exception);
}


@end
