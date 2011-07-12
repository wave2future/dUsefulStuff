//
//  SleepingTask.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/12/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCBackgroundTask.h"

@interface SleepingTask : NSObject<DCBackgroundTask> {
@private 
	float duration;
}

- (id)initWithDuration:(float) sleepDuration;

@end
