//
//  BusyIndicator.m
//  dBank
//
//  Created by Derek Clarkson on 22/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCBusyIndicator.h"
#import "DCCommon.h"
#import <dUsefulStuff/DCCommon.h>

@interface DCBusyIndicator()
-(void) show;
-(void) hide;
-(void) addDisplayWidgets;
@end

@implementation DCBusyIndicator

@dynamic message;
@synthesize transparency;
@synthesize parentView;

- (void) activate {
	DC_LOG(@"Posting show to main thread.");
	[self performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

- (void) deactivate {
	DC_LOG(@"Posting hide to main thread.");
	[self performSelectorOnMainThread:@selector(hide) withObject:nil waitUntilDone:NO];
}

-(void) addDisplayWidgets {
	
	DC_LOG(@"Adding busy indicator widgets");
	CGSize busyViewSize = self.frame.size;
	
	// Add the activity indicator.
	busy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	CGSize indicatorSize = busy.frame.size;
	CGFloat top = (busyViewSize.height - indicatorSize.height) / 2;
	CGFloat middle = (busyViewSize.width - indicatorSize.width) / 2;
	busy.frame = CGRectMake(middle, top, indicatorSize.width, indicatorSize.height);
	
	[self addSubview:busy];
	
	// Add the label.
	CGRect labelFrame = CGRectMake(20, top + busy.frame.size.height + 20, busyViewSize.width - 40, 44);
	label = [[UILabel alloc] initWithFrame:labelFrame];
	label.numberOfLines = 0;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	
	[self addSubview:label];
	
}

// This is executed on the main thread of the application.
-(void) show {
	
	DC_LOG(@"Showing busy indicator on main thread: %@", [NSThread currentThread]);
	
	// Grab the top windows top view as the parent if one has not been set.
	if (self.parentView == nil) {
		self.parentView = [[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0];
	}
	
	[self addDisplayWidgets];
	
	// Position this view below the parent view.
	CGSize parentViewSize = self.parentView.frame.size;
	
	[parentView	addSubview:self];
	self.frame = CGRectMake(0, parentViewSize.height, parentViewSize.width, parentViewSize.height);
	self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:transparency == 0 ? 0.75 : transparency];
	[busy startAnimating];
	
	// Animate.
	[UIView animateWithDuration:0.5 animations:^{
		CGRect newFrame = CGRectMake(0, 0, parentViewSize.width, parentViewSize.height);
		self.frame = newFrame;
	}];
}

// This is executed on the main thread of the application.
-(void) hide {
	DC_LOG(@"Hiding busy indicator on main thread.");
	[UIView animateWithDuration:0.5 
						  animations:^{
							  CGSize size = self.frame.size;
							  CGRect newFrame = CGRectMake(0, size.height,	size.width, size.height);
							  self.frame = newFrame;
						  }
	 
						  completion:^(BOOL finished){
							  [busy stopAnimating];
							  [self removeFromSuperview];
						  }
	 ];
}

-(void) setMessage:(NSString *)message {
	label.text = message;
}

-(NSString *) message {
	return label.text;
}

- (void) dealloc {
	self.parentView = nil;
	DC_DEALLOC(busy);
	DC_DEALLOC(label);
	[super dealloc];
}

@end
