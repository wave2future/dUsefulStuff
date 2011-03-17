//
//  DCDialogs.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/08/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCDialogs.h"
#import "DCCommon.h"
#import <UIKit/UIAlert.h>

@implementation DCDialogs

+ (void) displayMessage:(NSString *)msg {
	[DCDialogs displayMessage:msg title:@"Oops!"];
}

+ (void) displayMessage:(NSString *)msg title:(NSString *)title {

	DC_LOG(@"Displaying message: %@", msg);

	// Alert the user
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
	                                                message:msg
	                                               delegate:nil
	                                      cancelButtonTitle:@"Ok"
	                                      otherButtonTitles:nil];
	[alert show];
	[alert release];

}

@end
