//
//  ExternVariables.h
//  UtilLib
//
//  Created by AppDevelopper on 13-10-12.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat _h,_w;
extern CGRect _r,_containerRect;

extern NSString *APPNAME, *APPLINK, *FBICONLINK, *APPID;
extern NSString *ADMOB_KEY, *FLURRY_KEY, *IAP_KEY, *FB_KEY;
extern NSString *FB_CAPTION, *FB_DESCRIPTION, *FB_UPLOAD_IMAGE_MSG;
extern NSString *TWEETUSTEXT, *SUPPORTEMAILSUBJECT, *RECOMMENDEMAILSUBJECT, *RECOMMENDEMAILBODY;

extern NSString *UPLOAD_IMAGE_MSG, *FB_NEW_ALBUM_DESC,*SHARE_MSG;



extern BOOL isFirstOpen;
extern BOOL isUpdateOpen;
extern NSString *FONTNAME;



/// extern Fcns
void saveArchived(id, NSString*);
id loadArchived(NSString*);
void report_memory();

//NSDictionary* avosPoint(NSString* ,NSString*, NSString*);

@interface ExternVariables : NSObject

@end
