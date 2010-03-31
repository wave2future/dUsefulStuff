//
//  RatingTestAppDelegate.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "RatingTestAppDelegate.h"
#import "DCCommon.h"

@implementation RatingTestAppDelegate

@synthesize window;
@synthesize ratingController;

- (void) applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:ratingController.view];
	[window makeKeyAndVisible];
	DC_LOG(@"Main window loaded");
}

- (void) dealloc {
	self.window = nil;
	[super dealloc];
}

@end