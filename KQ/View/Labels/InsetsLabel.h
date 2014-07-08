//
//  InsetsLabel.h
//  GSMA
//
//  Created by AppDevelopper on 14-4-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel{

    UIEdgeInsets _insets;

}


@property (nonatomic, assign) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame insets:(UIEdgeInsets)insets;

@end
