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

+ (void) displayErrorOnView:(UIView * )view message:(NSString *)msg {
	[DCDialogs displayErrorOnView:view message:msg title:@"Oops!"];
}

+ (void) displayErrorOnView:(UIView * )view message:(NSString *)msg title:(NSString *)title {

	NSLog(@"Displaying error %@", msg);

	// Alert the user
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
	                                                message:msg
	                                               delegate:nil
	                                      cancelButtonTitle:@"Ok"
	                                      otherButtonTitles:nil];
	[alert show];
	[alert release];
	[msg release];

}

@end
