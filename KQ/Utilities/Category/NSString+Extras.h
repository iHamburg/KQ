//
//  NSString+Extras.h
//  GoBeepItZXing
//
//  Created by AppDevelopper on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Extras)


+ (NSString*)stringWithInt:(int)i;

+ (NSString*)stringWithFloat:(float)f;


/**
 适用于Setting类，需要修改的plist文件
 
 */
+ (NSString*)dataFilePath:(NSString*)fileName;

/**
 适用与不会发生修改的plist文件，每次只从bundle中读取！
 */
+ (NSString*)filePathForResource:(NSString*)fileName;


+ (NSString*)cachesPathForFileName:(NSString*)fileName; // caches file path

+ (NSString*)stringWithBeginDate:(NSDate*)beginDate finishDate:(NSDate*)finishDate;

- (BOOL)containSubString:(NSString*)subString;
@end
