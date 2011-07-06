//
//  ThreadManager.h
//  dBank
//
//  Created by Derek Clarkson on 23/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import "DCBusyIndicator.h"

/**
 * This class provides tools for dealing with threads.
 */
@interface DCBackgroundTask : NSObject {
	@private
	UIView *superView;
	SEL longRunningMethod;
	SEL notifyWhenFinishedMethod;
	id obj;
	DCBusyIndicator *busyIndicatorView;
}

@property (nonatomic, retain) UIView *superView;
@property (nonatomic) SEL longRunningMethod;
@property (nonatomic) SEL notifyWhenFinishedMethod;
@property (nonatomic, retain) id obj;

/**
 * Default constructor.
 */
- (DCBackgroundTask *) initWithMethod:(SEL)aLongRunningMethod onObject:(id)aObj;

/**
 * Call to start the task.
 */
- (void) start;

@end
