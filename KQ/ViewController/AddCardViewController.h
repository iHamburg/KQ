//
//  AddCardViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCardsViewController.h"

@interface AddCardViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, unsafe_unretained) UserCardsViewController *parent;



- (void)addCard:(NSString*)number;
- (void)validateWithBlock:(BooleanResultBlock)block;
@end
