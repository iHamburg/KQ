//
//  SettingController.h
//  GSMA
//
//  Created by AppDevelopper on 14-4-29.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableConfiguration.h"
#import <MessageUI/MessageUI.h>

@interface SettingController : UITableViewController<MFMailComposeViewControllerDelegate>{

    TableConfiguration *_config;
}


@property (nonatomic, strong) TableConfiguration *config;


- (void)aboutUs;
- (void)feedback;
- (void)version;
- (void)ratingUs;
- (void)recommend;
- (void)update;
@end
