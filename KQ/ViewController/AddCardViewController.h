//
//  AddCardViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCardsViewController.h"
#import "SignViewController.h"

@interface AddCardViewController : NetTableViewController<UITextFieldDelegate>

@property (nonatomic, unsafe_unretained) UserCardsViewController *parent;
@property (nonatomic, copy) BooleanResultBlock presentBlock;

- (void)toAgreement; //显示银联协议


- (void)addCard:(NSString*)number;
- (void)validateWithBlock:(BooleanResultBlock)block;

@end
