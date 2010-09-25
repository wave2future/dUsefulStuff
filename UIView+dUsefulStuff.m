//
//  UIView+dUsefulStuff.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "UIView+dUsefulStuff.h"
#import "DCCommon.h"
#import "UIColor+dUsefulStuff.h"

@implementation UIView (dUsefulStuff)

- (void) drawRoundedRectOnContext:(CGContextRef)context
  rectangle:(CGRect)rect
  radius:(int)radius
  borderWidth:(int)borderWidth
  borderColor:(UIColor *)borderColour
  fillColor:(UIColor *)fillColour {

	DC_LOG(@"Drawing rounded rectangle as background.");
	DC_LOG(@"Origin: %fx%f size: %fx%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

	int left = rect.origin.x + borderWidth - 1;
	int leftRadiusOrigin = left + radius;
	
	int right = rect.origin.x + rect.size.width - borderWidth + 1;
	int rightRadiusOrigin = right - radius;
	
	int top = rect.origin.y + borderWidth - 1;
	int topRadiusOrigin = top + radius;

	int bottom = rect.origin.y + rect.size.height - borderWidth + 1;
	int bottomRadiusOrigin = bottom - radius;

	/* Begin! */
	CGContextBeginPath(context);

	/* First corner */
	CGContextMoveToPoint(context, left, topRadiusOrigin);
	CGContextAddArcToPoint(context, left, top, leftRadiusOrigin, top, radius);

	CGContextAddLineToPoint(context, rightRadiusOrigin, top);

	/* Second corner */
	CGContextAddArcToPoint(context, right, top, right, topRadiusOrigin, radius);
	
	CGContextAddLineToPoint(context, right, bottomRadiusOrigin);

	/* Third corner */
	CGContextAddArcToPoint(context, right, bottom, rightRadiusOrigin, bottom, radius);
	
	CGContextAddLineToPoint(context, leftRadiusOrigin, bottom);

	/* Fourth corner */
	CGContextAddArcToPoint(context, left, bottom, left, bottomRadiusOrigin, radius);
	
	CGContextAddLineToPoint(context, left, topRadiusOrigin);

	/* Done */
	CGContextClosePath(context);

	CGContextSetAllowsAntialiasing(context, YES);
	CGContextSetShouldAntialias(context, YES);

	// Now draw it.
	BOOL borderHasColour = ![[UIColor clearColor] isEqualToColor:borderColour];
	BOOL fillHasColour = ![[UIColor clearColor] isEqualToColor:fillColour];
	if (borderHasColour && fillHasColour) {
		[borderColour setStroke];
		CGContextSetLineWidth(context, borderWidth);
		[fillColour setFill];
		CGContextDrawPath(context, kCGPathFillStroke);
	} else if (borderHasColour) {
		[borderColour setStroke];
		CGContextSetLineWidth(context, borderWidth);
		CGContextStrokePath(context);
	} else {
		[fillColour setFill];
		CGContextFillPath(context);
	}

}


@end
