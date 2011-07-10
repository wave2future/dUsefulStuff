//
//  ThreadManager.h
//  dBank
//
//  Created by Derek Clarkson on 23/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import "DCBusyIndicator.h"
#import "DCBackgroundThreadDelegate.h"
#import "DCBackgroundTask.h"

/**
 This class manages a thread that is to be run in the background. It can also display a DCBusyIndicator in a semi modal form. Byt this I mean that it slides
 up the screen covering the specified view. Usually you would use this to cover the main display whilst something is happening.
 */
@interface DCBackgroundThread : NSObject {
	@private
	NSObject<DCBackgroundTask> *task;
	NSObject<DCBackgroundThreadDelegate> *delegate;
	BOOL displayBusyIndicator;
	DCBusyIndicator *indicator;
	NSThread *backgroundThread;
	NSThread	*initiatingThread;
}

/// @name Properties

/**
 If set this object is notified when the task finishes or is cancelled.
 */
@property (assign, nonatomic) NSObject<DCBackgroundThreadDelegate> *delegate;

/// @name Initialisers

/**
 Default constructor. 
 
 @param theTask an instance of NSObject<DCBackgroundTask> which implments the code to be run in the background.
 */
- (id) initWithTask:(NSObject<DCBackgroundTask> *)theTask;

/// @name Tasks

/**
 Call to start the task.

 @eturn the thread object that was started.
 */
- (NSThread *) start;

/**
 Call this to send a cancel message to the thread.
 */
-(void) cancel;

@end
