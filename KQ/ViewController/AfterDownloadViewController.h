//
//  AfterDownloadViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-9-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "SignViewController.h"

@interface AfterDownloadViewController : SignViewController{

}

@property (nonatomic, assign) int source; // 0:从注册来，dissmiss； 1： 从coupondetails的下载来，pop

- (void)toAddCard;


@end
