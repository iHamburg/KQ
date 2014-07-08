//
//  NSMutableArray+Extras.h
//  NR
//
//  Created by  on 16.05.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extras)

- (void)addInt:(int)aInt;
- (void)addFloat:(float)aFloat;

- (void)swapA:(int)indexA withB:(int)indexB;
- (void)swapObjA:(id)objA withObjB:(id)objB;
/*
 @[@0,@1,@2,@3,@4,@5,@6]
 
 from 4->1
 
 0,4,1,2,3,5,6
 
 from 1->4
 
 0,2,3,4,1,5,6
 
 */
- (void)moveFrom:(int)indexFrom to:(int)indexTo;
@end
