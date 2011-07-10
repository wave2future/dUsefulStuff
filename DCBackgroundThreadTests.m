//
//  DCBackgroundThreadTests.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/9/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dUsefulStuff/DCCommon.h>
#import <GHUnit/GHUnit.h> 

#import "DCBackgroundThread.h"
#import "DCBackgroundTask.h"
#import "DCBackgroundThreadDelegate.h"

@interface DCBackgroundThreadTests : GHTestCase<DCBackgroundTask, DCBackgroundThreadDelegate> {
	@private
	BOOL threadExecuted;
	BOOL notifiedOfThreadFinishing;
	NSThread *testThread;
}
@end

@implementation DCBackgroundThreadTests

-(void) testBackgroundThreadRuns {
	testThread = [NSThread currentThread];
	DCBackgroundThread *thread = [[[DCBackgroundThread alloc] initWithTask:self] autorelease];
	[thread start];
	[NSThread sleepForTimeInterval: 0.5];
	GHAssertTrue(threadExecuted, @"Thread has not executed");
}

-(void) testDelegateIsNotified {
	testThread = [NSThread currentThread];
	testThread.name = @"Test thread";
	DCBackgroundThread *thread = [[[DCBackgroundThread alloc] initWithTask:self] autorelease];
	thread.delegate = self;
	[thread start];
	[NSThread sleepForTimeInterval: 0.1];
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	GHAssertTrue(notifiedOfThreadFinishing, @"Thread finished notification not sent");
}

// DCBackgroundTask protocol methods.

-(void) start {
	DC_LOG(@"start selector called on thread: %@", [NSThread currentThread]);
	GHAssertFalse([testThread isEqual:[NSThread currentThread]], @"Appears to be running in the same thread.");
	threadExecuted = YES;
}

// Delegate methods from DCBackgrondThreadDelegate

-(void) threadDidFinish:(NSThread *) thread {
	DC_LOG(@"Thread finished: %@", thread);
	DC_LOG(@"Test     thread: %@", testThread);
	GHAssertTrue([testThread isEqual:[NSThread currentThread]], @"Delegate should not be on background thread.");
	GHAssertFalse([testThread isEqual:thread], @"Test thread should be a different thread.");
	notifiedOfThreadFinishing = YES;
}

@end
