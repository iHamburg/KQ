//
//  Macros.h
//  Xappsoft
//
//  Created by Michael Zapf on 27.05.11.
//  Copyright 2011 Xappsoft. All rights reserved.
//




#define DefaultImg [UIImage imageNamed:@"quickquan_launcher.jpg"]




// -----------------------------------

#define LString(x) NSLocalizedString(x, nil)

#define GetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]

#define ISEMPTY(x)	(((x) == nil ||[(x) isKindOfClass:[NSNull class]] ||([(x) isKindOfClass:[NSString class]] &&  [(NSString*)(x) length] == 0) || ([(x) isKindOfClass:[NSArray class]] && [(NSArray*)(x) count] == 0))|| ([(x) isKindOfClass:[NSDictionary class]] && [(NSDictionary*)(x) count] == 0))

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPhone  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) 
#define isPhone4 ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina35)||([UIDevice resolution] == UIDeviceResolution_iPhoneStandard)
//#define isPhone5 ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4)

#define isStatusBarLandscape UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation])
#define isStatusBarPortrait UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication]statusBarOrientation])

#define isIAPFullVersion [[NSUserDefaults standardUserDefaults] boolForKey:IAP_KEY]

#define isRetina ([[UIScreen mainScreen] scale] != 1.0f)
#define kVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define kAutoResize (UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin)

#define isIOS8 (kVersion >= 8.0)
#define isIOS7 (kVersion >= 7.0)
#define isIOS6 (kVersion >= 6.0)
#define isIOS7Only (isIOS7 && !isIOS8)


#define kIsPad2 (isPad?2.0:1.0)
#define kRetinaScale [[UIScreen mainScreen]scale]

#pragma mark - Maths

#define ROUND(x)	(round((x)*10)/10.0)
#define degreesToRadians(x) ((x)/180.0f*M_PI)
#define TRANSFORM(degree) CGAffineTransformMakeRotation(M_PI*(degree)/180.0);

#pragma mark - Debug & Release



#ifdef DEBUG

#define L() NSLog(@"%s",__FUNCTION__)

#else


#define L()

#endif

#pragma mark -

#define kNewLine @"\r\n"

