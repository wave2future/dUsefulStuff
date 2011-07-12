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
#import "DCBusyIndicator.h"

@implementation RatingTestController
@synthesize ratingWhole;
@synthesize ratingHalf;
@synthesize ratingDouble;
@synthesize readOut;

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

	DCUIBubble * bubbleWhole = [[[DCUIBubble alloc] initWithBackgroundImage:myBubbleImage] autorelease];
	bubbleWhole.textOffsetXPixels = -2;
	bubbleWhole.textOffsetYPixels = -9;
	bubbleWhole.fontColor = [UIColor redColor];
	
	DCUIBubble * bubbleHalf = [[[DCUIBubble alloc] initWithBackgroundImage:myBubbleImage] autorelease];
	bubbleHalf.textOffsetXPixels = -2;
	bubbleHalf.textOffsetYPixels = -9;
	bubbleHalf.fontColor = [UIColor blueColor];

	DCUIBubble * bubbleDouble = [[[DCUIBubble alloc] initWithSize:CGSizeMake(50, 50)] autorelease];
	bubbleDouble.textOffsetXPixels = -2;
	bubbleDouble.textOffsetYPixels = -9;
	bubbleDouble.color = [UIColor orangeColor];
	bubbleDouble.borderColor = [UIColor blackColor];
	
	self.ratingWhole.onRatingImage = myRatingImage;
	self.ratingWhole.offRatingImage = myNoRatingImage;
	self.ratingWhole.bubble = bubbleWhole;
	self.ratingWhole.scale = DCRatingScaleWhole;
	self.ratingWhole.delegate = self;
	
	self.ratingHalf.onRatingImage = myRatingImage;
	self.ratingHalf.offRatingImage = myNoRatingImage;
	self.ratingHalf.halfRatingImage = myHalfRatingImage;
	self.ratingHalf.bubble = bubbleHalf;
	self.ratingHalf.scale = DCRatingScaleHalf;
	self.ratingHalf.delegate = self;
	self.ratingHalf.iconCount = 4;

	self.ratingDouble.onRatingImage = myRatingImage;
	self.ratingDouble.offRatingImage = myNoRatingImage;
	self.ratingDouble.halfRatingImage = myHalfRatingImage;
	self.ratingDouble.bubble = bubbleDouble;
	self.ratingDouble.scale = DCRatingScaleDouble;
	self.ratingDouble.delegate = self;
	self.ratingDouble.iconCount = 3;
}


-(void) ratingDidChange:(DCUIRating *) rating {
	self.readOut.text = [NSString stringWithFormat:@"Value: %f", rating.rating];
}

- (IBAction) alertButtonClicked:(id)button; {
	[DCDialogs displayMessage:@"Hello this is an alert"];
}

- (IBAction) alert2ButtonClicked:(id)button; {
	[DCDialogs displayMessage:@"Hello this is an alert" title:@"With a title"];
}

-(IBAction) busyIndicatorButtonClicked: (id) button {
	DCBusyIndicator * indicator = [[DCBusyIndicator alloc] initWithFrame:self.view.frame];
	indicator.message = @"Whoa!";
	[indicator activate];
	[indicator release];
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
