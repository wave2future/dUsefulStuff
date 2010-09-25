//
//  RatingTestController.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "RatingTestController.h"
#import "DCCommon.h"
#import "DCDialogs.h"
#import "DCUIBubble.h"

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

	DCUIBubble * bubble5 = [[DCUIBubble alloc] initWithBackgroundImage:myBubbleImage];
	bubble5.textOffsetXPixels = -2;
	bubble5.textOffsetYPixels = -9;
	bubble5.fontColor = [UIColor redColor];
	
	DCUIBubble * bubble5half = [[DCUIBubble alloc] initWithBackgroundImage:myBubbleImage];
	bubble5half.textOffsetXPixels = -2;
	bubble5half.textOffsetYPixels = -9;
	bubble5half.fontColor = [UIColor blueColor];

	DCUIBubble * bubble10 = [[DCUIBubble alloc] initWithSize:CGSizeMake(50, 50)];
	bubble10.textOffsetXPixels = -2;
	bubble10.textOffsetYPixels = -9;
	bubble10.color = [UIColor orangeColor];
	bubble10.borderColor = [UIColor blackColor];
	
	self.rating5.onRatingImage = myRatingImage;
	self.rating5.offRatingImage = myNoRatingImage;
	self.rating5.bubble = bubble5;
	self.rating5.scaleType = DC_SCALE_0_TO_5;
	
	self.rating5half.onRatingImage = myRatingImage;
	self.rating5half.offRatingImage = myNoRatingImage;
	self.rating5half.halfRatingImage = myHalfRatingImage;
	self.rating5half.bubble = bubble5half;
	self.rating5half.scaleType = DC_SCALE_0_TO_5_WITH_HALVES;

	self.rating10.onRatingImage = myRatingImage;
	self.rating10.offRatingImage = myNoRatingImage;
	self.rating10.halfRatingImage = myHalfRatingImage;
	self.rating10.bubble = bubble10;
	self.rating10.scaleType = DC_SCALE_0_TO_10;

}

- (IBAction) alertButtonClicked:(id)button; {
	[DCDialogs displayMessage:@"Hello this is an alert"];
}

- (IBAction) alert2ButtonClicked:(id)button; {
	[DCDialogs displayMessage:@"Hello this is an alert" title:@"With a title"];
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
