//
//  EventViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-9-1.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController


@property (nonatomic, strong) IBOutlet UIImageView *bgV;
@property (nonatomic, copy) void(^back)(void);
@end
