//
//  UserCardsViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetTableViewController.h"

@interface UserCardsViewController : NetTableViewController


- (IBAction)addCard;

- (void)deleteCardAtIndexPath:(NSIndexPath*)indexPath;

@end
