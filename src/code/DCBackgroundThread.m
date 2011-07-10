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
@end


@implementation DCBackgroundThread

@synthesize delegate;

- (id) initWithTask:(NSObject<DCBackgroundTask> *)theTask {
	self = [super init];
	if (self != nil) {
		task = [theTask retain];
		initiatingThread = [[NSThread currentThread] retain];
	}
	return self;
}

- (NSThread *) start {
	
	DC_LOG(@"Starting background thread");
	
	// Fire ourselves into the background.
	backgroundThread = [[NSThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
	backgroundThread.name = @"BackgroundTask thread";

	DC_LOG(@"Watching thread: %@", backgroundThread);
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(taskFinished:)
	                                             name:NSThreadWillExitNotification
	                                           object:backgroundThread];
	[backgroundThread start];
	return backgroundThread;
}

-(void) cancel {
	DC_LOG(@"Cancelling thread: %@", [NSThread currentThread]);
	[backgroundThread cancel];
}

/**
 This is executed in the background so we need a new autorelease pool, etc.
 */
- (void) execute {

	// New thread = new pool.
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	DC_LOG(@"Executing on thread: %@", [NSThread currentThread]);
	
	if (displayBusyIndicator) {
		DC_LOG(@"Turning on busy indicator");
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		indicator = [[DCBusyIndicator alloc] initWithSuperview:window];
		[indicator performSelectorOnMainThread:@selector(activate) withObject:nil waitUntilDone:YES];
	}
	
	// Do the work on this thread.
	[task start];
	
	if (displayBusyIndicator) {
		DC_LOG(@"Removing busy indicator view");
		[indicator performSelectorOnMainThread:@selector(deactivate) withObject:nil waitUntilDone:YES];
		DC_DEALLOC(indicator);
	}
	
	[pool release];
	
}

- (void) taskFinished:(NSNotification *)notification {
	DC_LOG(@"Thread exiting message from %@", notification.object);
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSThreadWillExitNotification object:notification.object];
	DC_LOG(@"Sending [%@ threadDidFinish:%@] to originating thread: %@", delegate, backgroundThread, initiatingThread);
	[self performSelector:@selector(forwardFinishedNotification:) onThread:initiatingThread withObject:backgroundThread waitUntilDone:NO];
}

// This is so that we can cast the thread to the correct type.
- (void) forwardFinishedNotification:(id) thread {
	DC_LOG(@"back on initiating thread, forwarding finished notification");
	[delegate threadDidFinish:thread];
}


- (void) dealloc {
	self.delegate = nil;
	DC_DEALLOC(backgroundThread);
	DC_DEALLOC(initiatingThread);
	DC_DEALLOC(task);
	[super dealloc];
}


@end
