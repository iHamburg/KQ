//
//  ExternVariables.m
//  UtilLib
//
//  Created by AppDevelopper on 13-10-12.
//  Copyright (c) 2013年 Xappsoft. All rights reserved.
//

#import "ExternVariables.h"
#import "Category.h"
#import "mach/mach.h"


CGFloat _h,_w;
CGRect _r,_containerRect;

NSString *APPNAME, *APPLINK,*FBICONLINK,*APPID;
NSString *FB_CAPTION, *FB_DESCRIPTION;
NSString *TWEETUSTEXT, *SUPPORTEMAILSUBJECT,  *RECOMMENDEMAILSUBJECT, *RECOMMENDEMAILBODY;
NSString *ADMOB_KEY, *FLURRY_KEY, *IAP_KEY, *FB_KEY;
NSString *UPLOAD_IMAGE_MSG, *FB_NEW_ALBUM_DESC, *SHARE_MSG;



BOOL isFirstOpen;
BOOL isUpdateOpen;
NSString *FONTNAME;

void saveArchived(id obj, NSString *name){
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	[archiver encodeObject:obj forKey:name];
	[archiver finishEncoding];
    
    NSString *filePath = [NSString dataFilePath:name];
	[data writeToFile:filePath atomically:YES];
	
}

id loadArchived(NSString* name){
	
	NSString *filePath = [NSString dataFilePath:name];
    
    
	id obj = nil;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
		NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		obj = [unarchiver decodeObjectForKey:name];
		[unarchiver finishDecoding];
	}
	return obj;
}


void report_memory() {
    
#ifdef DEBUG
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
        
		NSLog(@"Memory in use (in MB): %d", (info.resident_size/1024));
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }
    
	
#endif
	
}

UIFont* nFont(int x){
    return  [UIFont fontWithName:kFontName size:x];
}
UIFont* bFont(int x){
    return  [UIFont fontWithName:kFontBoldName size:x];
}

//BOOL isPaid(void){
//	
//	BOOL flag;
//	
//#ifdef FREE
//	flag = NO;
//#else
//	flag= YES;
//#endif
//	
//	return flag;
//}

@implementation ExternVariables

@end
