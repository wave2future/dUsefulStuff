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

	[self.rating5 setupControlWithRatingImage:myRatingImage noRatingImage:myNoRatingImage halfRatingImage:nil padding:0 scaleType:DC_SCALE_0_TO_5];

	[self.rating5half setupControlWithRatingImage:myRatingImage noRatingImage:myNoRatingImage halfRatingImage:myHalfRatingImage padding:0 scaleType:DC_SCALE_0_TO_5_WITH_HALVES];

	[self.rating10 setupControlWithRatingImage:myRatingImage noRatingImage:myNoRatingImage halfRatingImage:myHalfRatingImage padding:0 scaleType:DC_SCALE_0_TO_10];

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
