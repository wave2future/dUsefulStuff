//
//  UIView+dUsefulStuff.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Additional methods for UIViews
 */
@interface UIView (dUsefulStuff)

/**
 This method will drawn a rounded rectangle on the supplied graphics context.
 
 Usually you would call this from a UIView:drawRect: method like this

	- (void) drawRect:(CGRect)rect {
		[self drawRoundedRectOnContext:UIGraphicsGetCurrentContext() rectangle:self.bounds radius:10];
	}

 Notice we are passing the bounds which effective is the size of the control and therefore draws
 the rounded rectangle arond the edges of the control.
 
 @param context the CGContextRef to draw on.
 @param rect a rectangle which defines where to draw the rounded rectangle.
 @param radius how many pixels the rounded corners should be.
 @param borderWidth the width in pixels to make the border.
 @param borderColour the colour to make the border. If this is the clear colour, then no border is drawn.
 @param fillColour the colour to fill the rectangle with. If this is clear then the rectangle is not filled.
 */
- (void) drawRoundedRectOnContext:(CGContextRef)context
								rectangle:(CGRect)rect
									radius:(int)radius
							 borderWidth:(int)borderWidth
							 borderColor:(UIColor *)borderColour
								fillColor:(UIColor *)fillColour;

@end
