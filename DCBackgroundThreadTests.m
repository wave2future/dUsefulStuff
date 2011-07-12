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
#import "CancellableTask.h"
#import "SleepingTask.h"

@interface DCBackgroundThreadTests : GHTestCase<DCBackgroundTask, DCBackgroundThreadDelegate> {
	@private
	BOOL threadExecuted;
	BOOL notifiedOfThreadFinishing;
	BOOL notifiedOfThreadCancelling;
	NSThread *testThread;
}
@end

@implementation DCBackgroundThreadTests

-(void) setUp {
	threadExecuted = NO;
	notifiedOfThreadFinishing = NO;
	notifiedOfThreadCancelling = NO;
	testThread = nil;
}

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
	DC_LOG(@"Sleeping thread");
	[NSThread sleepForTimeInterval: 0.2];
	DC_LOG(@"Waking up");

	DC_LOG(@"Calling run loop to allow notifications to execute");
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];

	GHAssertTrue(threadExecuted, @"Thread has not executed");
	GHAssertTrue(notifiedOfThreadFinishing, @"Thread finished notification not sent");
}

-(void) testCancellingKillsThread {
	
	testThread = [NSThread currentThread];
	testThread.name = @"Test thread cancel";
	CancellableTask *task = [[[CancellableTask alloc] init] autorelease];
	DCBackgroundThread *thread = [[[DCBackgroundThread alloc] initWithTask:task] autorelease];
	thread.delegate = self;
	
	NSThread *actualThread = [thread start];
	[thread cancel];

	[NSThread sleepForTimeInterval: 1.0];

	DC_LOG(@"Calling run loop to allow notifications to execute");
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
	
	GHAssertFalse(notifiedOfThreadFinishing, @"Thread finished sent");
	GHAssertTrue(notifiedOfThreadCancelling, @"Thread cancelled notification not sent");
	GHAssertTrue([actualThread isCancelled], @"Thread was not cancelled");
}

-(void) testBusyIndicatorIsDisplayed {
	
	testThread = [NSThread currentThread];
	SleepingTask *task = [[[SleepingTask alloc] initWithDuration:0.6] autorelease];
	DCBackgroundThread *thread = [[[DCBackgroundThread alloc] initWithTask:task] autorelease];
	thread.displayBusyIndicator = YES;

	DC_LOG(@"Starting thread");
	[thread start];
	DC_LOG(@"Test exiting.");
}

// *****************************************************************
// DCBackgroundTask protocol methods.

-(void) start {
	DC_LOG(@"start selector called on thread: %@", [NSThread currentThread]);
	GHAssertFalse([testThread isEqual:[NSThread currentThread]], @"Appears to be running in the same thread.");
	threadExecuted = YES;
}

// *****************************************************************
// Delegate methods from DCBackgrondThreadDelegate

-(void) threadDidFinish:(NSThread *) thread {
	DC_LOG(@"Thread finished: %@", thread);
	DC_LOG(@"Test thread    : %@", testThread);
	GHAssertTrue([testThread isEqual:[NSThread currentThread]], @"Delegate should not be on background thread.");
	GHAssertFalse([testThread isEqual:thread], @"Test thread should be a different thread.");
	notifiedOfThreadFinishing = YES;
}

-(void) threadWasCancelled:(NSThread *) thread {
	DC_LOG(@"Thread cancelled: %@", thread);
	DC_LOG(@"Test thread     : %@", testThread);
	GHAssertTrue([testThread isEqual:[NSThread currentThread]], @"Delegate should not be on background thread.");
	GHAssertFalse([testThread isEqual:thread], @"Test thread should be a different thread.");
	notifiedOfThreadCancelling = YES;
}

@end
