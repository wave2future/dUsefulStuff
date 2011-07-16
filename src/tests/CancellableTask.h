//
//  CancellableTask.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 7/10/11.
//  Copyright 2011 Sensis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCBackgroundTask.h"

@interface CancellableTask : NSObject<DCBackgroundTask> {
@private
	int counter;
}

@end
