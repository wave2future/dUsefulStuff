//
//  CancellableTask.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/10/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import "DCCommon.h"
#import "CancellableTask.h"

@implementation CancellableTask

-(void) start {
	for (counter = 0; counter < 1000000; counter++) {
		DC_LOG(@"Counter: %i", counter);
		[NSThread sleepForTimeInterval:0.1];
		if ([[NSThread currentThread] isCancelled]) {
			DC_LOG(@"Thread cancelled.");
			break;
		}
	}
}

@end
