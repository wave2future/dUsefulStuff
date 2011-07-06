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

@implementation DCBusyIndicator

@dynamic message;
@synthesize transparency;

- (id) initWithSuperview:(UIView *)aSuperView {

	CGRect frame = aSuperView.frame;
	DC_LOG_LAYOUT(aSuperView);
	CGRect offscreen = CGRectMake(0, aSuperView.window.frame.size.height, frame.size.width, frame.size.height);

	self = [super initWithFrame:offscreen];

	if (self) {

		// use a weak reference to refer to the super view.
		superView = aSuperView;
		
		transparency = 0.75;
		
		// Add the activity indicator.
		busy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		CGSize parentSize = aSuperView.frame.size;
		CGSize indicatorSize = busy.frame.size;
		CGFloat top = (parentSize.height - indicatorSize.height) / 2;
		CGFloat middle = (parentSize.width - indicatorSize.width) / 2;
		busy.frame = CGRectMake(middle, top, indicatorSize.width, indicatorSize.height);
		[self addSubview:busy];

		// Add the label.
		CGRect labelFrame = CGRectMake(20, top + busy.frame.size.height + 20, self.frame.size.width - 40, 44);
		label = [[UILabel alloc] initWithFrame:labelFrame];
		label.numberOfLines = 0;
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];

	}
	return self;
}

- (void) activate {
	self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
	[superView.window	addSubview:self];
	[busy startAnimating];
	[UIView animateWithDuration:0.5 animations:^{
		CGRect newFrame = CGRectMake(0, superView.frame.origin.y, self.frame.size.width, self.frame.size.height);
		self.frame = newFrame;
	}];
}

- (void) deactivate {
	[busy stopAnimating];
	[self removeFromSuperview];
}

-(void) setMessage:(NSString *)message {
	label.text = message;
}

-(NSString *) message {
	return label.text;
}

- (void) dealloc {
	DC_DEALLOC(busy);
	DC_DEALLOC(label);
	[super dealloc];
}

@end
