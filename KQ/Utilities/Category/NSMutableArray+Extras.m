//
//  NSMutableArray+Extras.m
//  NR
//
//  Created by  on 16.05.12.
//  Copyright (c) 2012 Xappsoft. All rights reserved.
//

#import "NSMutableArray+Extras.h"

@implementation NSMutableArray (Extras)

- (void)addInt:(int)aInt{
	[self addObject:[NSString stringWithFormat:@"%d",aInt]];
}
- (void)addFloat:(float)aFloat{

	[self addObject:[NSString stringWithFormat:@"%f",aFloat]];
}

- (void)swapA:(int)indexA withB:(int)indexB{
	NSAssert(indexA>=0 && indexB >=0 && indexA<[self count] &&indexB < self.count, @"Swap Index Error");
	
	id temp = self[indexA];
	[self replaceObjectAtIndex:indexA withObject:self[indexB]];
	[self replaceObjectAtIndex:indexB withObject:temp];
	
}


- (void)swapObjA:(id)objA withObjB:(id)objB{
    NSAssert([self containsObject:objA] && [self containsObject:objB], @"Swap other obj");
    
    int indexA =[self indexOfObject:objA];
    int indexB = [self indexOfObject:objB];
    [self replaceObjectAtIndex:indexA withObject:objB];
    [self replaceObjectAtIndex:indexB withObject:objA];
    
}

- (void)moveFrom:(int)indexFrom to:(int)indexTo{
	NSAssert3(indexFrom >= 0 && indexTo>=0 && indexFrom<[self count] && indexTo<[self count], @"Error: %s # From %d To %d ", __FUNCTION__, indexFrom,indexTo);
	
	id temp = self[indexFrom];
	[self removeObjectAtIndex:indexFrom];
	[self insertObject:temp atIndex:indexTo];
	
}
@end
