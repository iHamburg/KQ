//
//  TextfieldCell.m
//  KQ
//
//  Created by Forest on 14-11-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TextfieldCell.h"

@implementation TextfieldCell{
    UITextField *_tf;
}

- (id)value{
    return _tf.text;
}

- (UITextField*)subView{
    return _tf;
}

- (void)load{
    
    [super load];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    self.accessoryView = _tf;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


@end
