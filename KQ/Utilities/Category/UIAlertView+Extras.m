//
//  UIAlertView+Extras.m
//  Supercry
//
//  Created by AppDevelopper on 17.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIAlertView+Extras.h"


@implementation UIAlertView (UIAlertView_Extras)

+ (void)showAlert:(NSString*)title msg:(NSString*)msg{
               
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:LString(@"OK")
                                                      otherButtonTitles:nil];
[alert show];

}

+ (void)showAlert:(NSString*)title msg:(NSString*)msg cancel:(NSString*)cancel{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:nil];
    [alert show];

}

+ (void)showAlertWithError:(NSError*)error{

    if (error) {
        NSString *title = LString(@"服务器返回Json格式错误");//f
        NSString *msg = [error localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:LString(@"OK") otherButtonTitles:nil];
        
        [alert show];

    }
}
@end
