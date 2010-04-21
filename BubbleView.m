//
//  BubbleView.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 19/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "BubbleView.h"
#import "DCCommon.h"


@implementation BubbleView

@synthesize value;

- (BubbleView *) initWithImage:(UIImage *)backgroundImage {
	self = [super initWithFrame:CGRectMake(0, -backgroundImage.size.height, backgroundImage.size.width, backgroundImage.size.height)];
	if (self) {
		DC_LOG(@"Creating bubble");
		width = backgroundImage.size.width;
		height = backgroundImage.size.height;
		background = [backgroundImage retain];
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		self.hidden = YES;
	}
	return self;
}

- (void) drawRect:(CGRect)rect {
	DC_LOG(@"Drawing bubble");
	[background drawInRect:CGRectMake(0, 0, width, height)];
}

- (void) moveToX:(int)x {
	DC_LOG(@"Moving bubble to %i", x);
	self.frame = CGRectMake(x, -height, width, height);
}


- (void) dealloc {
	DC_DEALLOC(background);
	[super dealloc];
}


@end
