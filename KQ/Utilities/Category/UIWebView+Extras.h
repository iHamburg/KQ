//
//  UIWebView+Extras.h
//  TheBootic
//
//  Created by  on 22.12.11.
//  Copyright (c) 2011 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Extras)

- (void)loadHTMLStringFromFileName:(NSString*)fileName baseURL:(NSURL*)baseURL;
- (void)loadFileName:(NSString*)fileName;
- (void)loadFilePath:(NSString*)filePath;
- (void)loadURLString:(NSString*)urlString;

@end
