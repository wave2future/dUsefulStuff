//
//  DCBackgroundTask.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/9/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class which implement this protocol can be run in the background by the DCBackgroundThread class.
 */
@protocol DCBackgroundTask <NSObject>

/**
 This method is called by DCBackgroundThread to start the background processing.
 */
-(void) start;

@end
