//
//  RatingTestController.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "RatingTestController.h"
#import "DCCommon.h"


@implementation RatingTestController
@synthesize rating5;
@synthesize rating5half;
@synthesize rating10;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad {
	DC_LOG(@"View did load");
	[super viewDidLoad];

	NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"star" ofType:@"png"];
	UIImage *myNoRatingImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];

	imagePath = [[NSBundle mainBundle] pathForResource:@"star-half-active" ofType:@"png"];
	UIImage *myHalfRatingImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];

	imagePath = [[NSBundle mainBundle] pathForResource:@"star-active" ofType:@"png"];
	UIImage *myRatingImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];

	imagePath = [[NSBundle mainBundle] pathForResource:@"bubble" ofType:@"png"];
	UIImage *myBubbleImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];

	self.rating5.onRatingImage = myRatingImage;
	self.rating5.offRatingImage = myNoRatingImage;
	self.rating5.bubbleBackgroundImage = myBubbleImage;
	self.rating5.scaleType = DC_SCALE_0_TO_5;
	[self.rating5 setupControl];

	self.rating5half.onRatingImage = myRatingImage;
	self.rating5half.offRatingImage = myNoRatingImage;
	self.rating5half.halfRatingImage = myHalfRatingImage;
	self.rating5half.bubbleBackgroundImage = myBubbleImage;
	self.rating5half.scaleType = DC_SCALE_0_TO_5_WITH_HALVES;
	self.rating10.bubbleTextColour = [UIColor blueColor];
	self.rating5half.bubbleTextXOffset = -2;
	self.rating5half.bubbleTextYOffset = 3;
	[self.rating5half setupControl];

	self.rating10.onRatingImage = myRatingImage;
	self.rating10.offRatingImage = myNoRatingImage;
	self.rating10.halfRatingImage = myHalfRatingImage;
	self.rating10.bubbleBackgroundImage = myBubbleImage;
	self.rating10.scaleType = DC_SCALE_0_TO_10;
	self.rating10.bubbleTextColour = [UIColor redColor];
	self.rating10.bubbleTextFont = [UIFont boldSystemFontOfSize:14.0];
	self.rating10.bubbleTextXOffset = -2;
	self.rating10.bubbleTextYOffset = 5;
	[self.rating10 setupControl];
	
}


- (void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void) viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void) dealloc {
	[super dealloc];
}


@end
