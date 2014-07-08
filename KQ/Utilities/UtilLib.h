//
//  UtilLib.h
//  UtilLib
//
//  Created by AppDevelopper on 06.06.13.
//  Copyright (c) 2013 Xappsoft. All rights reserved.
//
//


/**
 
 
 加入的方式：
 
 1. 把UtilLib.xcodeproj拖曳到framework下
 2. 加入UtilLib.a framework
 3. Header Search Path: ~/Public/WorkProject/UtilLib, 并且recursive
 4. Other Link Flag: -ObjC
 
 Framework:
 
 QuartzCore
 CoreGraphic
 StoreKit
 
 Flurry
    Security
    SystemConfiguration
 
 Export
    MessageUI
    Tweet
 
 Google Admob
     AudioToolbox
     AdSupport
     MessageUI (ja)
     SystemConfiguration (ja)
     CoreGraphics (ja)
      StoreKit(ja)
 */


#import "Constant.h"
#import "Macros.h"
#import "Category.h"
#import "Strings.h"
#import "ExternVariables.h"


