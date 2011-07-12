//
//  ThreadManager.m
//  dBank
//
//  Created by Derek Clarkson on 23/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCBackgroundThread.h"
#import "DCBusyIndicator.h"
#import <dUsefulStuff/DCCommon.h>

@interface DCBackgroundThread ()

- (void) execute;
- (void) taskFinished:(NSNotification *)notification;
- (void) forwardFinishedNotification:(id) thread;
- (void) forwardCancelledNotification:(id) thread;
@end


@implementation DCBackgroundThread

@synthesize delegate;
@synthesize displayBusyIndicator;

- (id) initWithTask:(NSObject<DCBackgroundTask> *)theTask {
	self = [super init];
	if (self != nil) {
		task = [theTask retain];
		initiatingThread = [[NSThread currentThread] retain];
	}
	return self;
}

- (NSThread *) start {
	
	DC_LOG(@"Starting background thread from thread %@", [NSThread currentThread]);
	
	// Fire ourselves into the background.
	backgroundThread = [[NSThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
	backgroundThread.name = @"BackgroundTask thread";
	
	DC_LOG(@"Adding notification observer for background thread: %@", backgroundThread);
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(taskFinished:)
	                                             name:NSThreadWillExitNotification
	                                           object:backgroundThread];
	[backgroundThread start];
	return backgroundThread;
}

-(void) cancel {
	DC_LOG(@"Cancelling background thread: %@", backgroundThread);
	[backgroundThread cancel];
}

/**
 This is executed in the background so we need a new autorelease pool, etc.
 */
- (void) execute {
	
	// New thread = new pool.
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	DC_LOG(@"Executing background thread: %@", [NSThread currentThread]);
	
	if (displayBusyIndicator) {
		DC_LOG(@"Turning on busy indicator");
		UIView *topView = [[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0];
		indicator = [[DCBusyIndicator alloc] initWithFrame:topView.frame];
		[indicator activate];
	}
	
	// Do the work on this thread.
	DC_LOG(@"Calling start method on thread: %@", [NSThread currentThread]);
	[task start];
	DC_LOG(@"Task finished");
	
	if (displayBusyIndicator) {
		DC_LOG(@"Removing busy indicator view");
		[indicator deactivate];
		DC_DEALLOC(indicator);
	}
	
	[pool release];
	
}

- (void) taskFinished:(NSNotification *)notification {

	DC_LOG(@"Thread exiting message from thread: %@", notification.object);
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSThreadWillExitNotification object:notification.object];
	
	if ([backgroundThread isCancelled]) {
		[self performSelector:@selector(forwardCancelledNotification:) onThread:initiatingThread withObject:backgroundThread waitUntilDone:NO];
	} else {
		[self performSelector:@selector(forwardFinishedNotification:) onThread:initiatingThread withObject:backgroundThread waitUntilDone:NO];
	}
}

// This is so that we can cast the thread to the correct type.
- (void) forwardFinishedNotification:(id) thread {
	DC_LOG(@"back on initiating thread, forwarding finished notification");
	[delegate threadDidFinish:thread];
}

- (void) forwardCancelledNotification:(id) thread {
	DC_LOG(@"back on initiating thread, forwarding cancelled notification");
	[delegate threadWasCancelled:thread];
}

- (void) dealloc {
	self.delegate = nil;
	DC_DEALLOC(backgroundThread);
	DC_DEALLOC(initiatingThread);
	DC_DEALLOC(task);
	[super dealloc];
}

@end
