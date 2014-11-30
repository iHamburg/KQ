//
//  InteractiveButton.h
//  KQ
//
//  Created by Forest on 14-11-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveButton : UIButton{
    UIActivityIndicatorView *_activityV;
}

@property (nonatomic, strong) NSString *text;

- (void)startLoading;
- (void)stopLoading;


@end
