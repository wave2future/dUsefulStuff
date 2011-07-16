//
//  SleepingTask.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/12/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import "SleepingTask.h"
#import "DCCommon.h"

@implementation SleepingTask

- (id)initWithDuration:(float) sleepDuration
{
    self = [super init];
    if (self) {
		 duration = sleepDuration;
    }
    return self;
}

-(void) start {
	DC_LOG(@"About to sleep for %f on thread: %@", duration, [NSThread currentThread]);
	[NSThread sleepForTimeInterval:duration];
	DC_LOG(@"Waking up.");
}
@end
