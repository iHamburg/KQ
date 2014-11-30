//
//  SwitcherCell.m
//  KQ
//
//  Created by AppDevelopper on 14-6-27.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell{
    UISwitch *_switch;
}

- (id)value{
    return _switch;
}

- (void)load{

    [super load];
    
    _switch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _switch.selected = YES;
    self.accessoryView = _switch;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
@end
