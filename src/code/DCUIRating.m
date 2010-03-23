//
//  DCUIRating.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCUIRating.h"
#import "DCCommon.h"

@interface DCUIRating ()

- (void) handleTouch:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@implementation DCUIRating
@synthesize maxValue;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Beginning touch event");
	//CGFloat relativeTouchLocation = [event locationInView:self] / self.bounds.size.width;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Ending touch event");

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Touch moved event");

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Touch cancelled event");

}

- (void) drawRect:(CGRect)rect { // From UIView
	DC_LOG(@"Drawing ratings");
}

- (void) handleTouch:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

@end
