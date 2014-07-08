//
//  TagsView.h
//  KQ
//
//  Created by AppDevelopper on 14-6-28.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsView : UIView{
    
    IBOutlet UIButton *_b1, *_b2, *_b3;
    
    NSArray *_buttons;
}

/// 3个button
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void(^selectBlock)(int);

- (IBAction)buttonPressed:(id)sender;

@end
