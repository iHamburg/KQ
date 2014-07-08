//
//  UserCenterViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ConfigViewController.h"



@interface UserCenterViewController : ConfigViewController<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    People *_people;

}

//@property (nonatomic, strong)

- (IBAction)logout;

- (void)toCoupons;
- (void)toShops;
- (void)toCards;
- (void)toFavoritedCoupons;
- (void)toSettings;
- (void)willLogout;
/**
 *	@brief	登录成功
 */
- (void)didLogin;

@end
