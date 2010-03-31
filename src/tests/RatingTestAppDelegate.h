//
//  RatingTestAppDelegate.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingTestController.h"

@interface RatingTestAppDelegate : NSObject <UIApplicationDelegate> {
@private
	UIWindow *window;
	RatingTestController * ratingController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RatingTestController * ratingController;

@end
