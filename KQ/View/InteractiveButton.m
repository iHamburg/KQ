//
//  InteractiveButton.m
//  KQ
//
//  Created by Forest on 14-11-12.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "InteractiveButton.h"

@implementation InteractiveButton

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _activityV = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        _activityV.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
        
        [self addSubview:_activityV];
        
    }
    return self;
}

- (void)startLoading{
//    self.text = self.titleLabel.text;
//    self.titleLabel.alpha = 0;
    
    [_activityV startAnimating];
    
    
}
- (void)stopLoading{
    [_activityV stopAnimating];
}
@end
