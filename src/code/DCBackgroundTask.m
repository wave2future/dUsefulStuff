//
//  ThreadManager.m
//  dBank
//
//  Created by Derek Clarkson on 23/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCBackgroundTask.h"
#import "DCBusyIndicator.h"
#import <dUsefulStuff/DCCommon.h>

@interface DCBackgroundTask ()

- (void) execute:(id)anObject;
- (void) taskFinished:(NSNotification *)notification;
- (void) notifyObject;
@end


@implementation DCBackgroundTask

@synthesize superView;
@synthesize longRunningMethod;
@synthesize notifyWhenFinishedMethod;
@synthesize obj;

- (DCBackgroundTask *) initWithMethod:(SEL)aLongRunningMethod onObject:(id)aObj {
	self = [super init];
	if (self != nil) {
		self.longRunningMethod = aLongRunningMethod;
		self.obj = aObj;
	}
	return self;
}

- (void) start {
	// Fire into the background.
	NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(execute:)object:nil];
	thread.name = @"BackgroundTask thread";
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(taskFinished:)
	                                             name:NSThreadWillExitNotification
	                                           object:thread];
	[thread start];
	[thread release];
}

- (void) execute:(id)anObject {

	// New thread = new pool.
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	if (self.superView != nil) {
		DC_LOG(@"Turning on busy indicator");
		busyIndicatorView = [[DCBusyIndicator alloc] initWithSuperview:self.superView];
		[busyIndicatorView performSelectorOnMainThread:@selector(addToSuperView)withObject:nil waitUntilDone:YES];
	}

	// Do the work on this thread.
	DC_LOG(@"Executing workload");
	[self.obj performSelector:self.longRunningMethod];

	if (self.superView != nil) {
		DC_LOG(@"Removing busy indicator view");
		[busyIndicatorView performSelectorOnMainThread:@selector(removeFromSuperView)withObject:nil waitUntilDone:YES];
		DC_DEALLOC(busyIndicatorView);
	}

	[pool release];

}

- (void) taskFinished:(NSNotification *)notification {
	DC_LOG(@"Thread exiting message from %@", notification.object);
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSThreadWillExitNotification object:notification.object];
	[self performSelectorOnMainThread:@selector(notifyObject)withObject:nil waitUntilDone:NO];
}

- (void) notifyObject {
	// Tell the main thread we are done.
	if (self.notifyWhenFinishedMethod != nil) {
		DC_LOG(@"Notifying main thread data is loaded, by posting event.");
		[self.obj performSelectorOnMainThread:self.notifyWhenFinishedMethod withObject:nil waitUntilDone:NO];
	}
}

- (void) dealloc {
	self.notifyWhenFinishedMethod = nil;
	self.superView = nil;
	self.longRunningMethod = nil;
	self.obj = nil;
	[super dealloc];
}


@end
