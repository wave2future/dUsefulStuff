//
//  DCBackgroundTaskDelegate.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/6/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 Classes that implement this protocol can receive notifications from a DCBackgroundTask that a thread has finished or been cancelled.
 */
@protocol DCBackgroundThreadDelegate <NSObject>

/**
 Called when a DCBackgroundTask finishes normally.
 
 @param thread the thread that just finished.
 */
-(void) threadDidFinish:(NSThread *) thread;

@optional

/**
 Called when a DCBackgroundTask has it's thread cancelled.

 @param thread the thread that was cancelled.
 */
-(void) threadWasCancelled:(NSThread *) thread;

@end
