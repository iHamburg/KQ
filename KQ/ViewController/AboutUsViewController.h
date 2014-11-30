//
//  AboutUsViewController.h
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"
#import <MessageUI/MessageUI.h>

@interface AboutUsViewController : ConfigViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) MFMailComposeViewController *globalMailComposer;

- (IBAction)feedbackPressed:(id)sender;
- (IBAction)cooperatePressed:(id)sender;

- (void)showFeedback;
- (void)pushCooperate;
@end
