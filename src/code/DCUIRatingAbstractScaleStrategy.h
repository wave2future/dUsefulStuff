//
//  DCUIRatingAbstractScaleStrategy.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/4/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUIRatingScaleStrategy.h"

/**
 * This is an abstract class for strategies. It puts in place everything that all strategies do.
 */
@interface DCUIRatingAbstractScaleStrategy : NSObject <DCUIRatingScaleStrategy> {
	UIImage * onImage;
	UIImage * offImage;
	UIImage * halfOnImage;
	float rating;
	int imageWidth;
	int zeroAreaWidth;
}

/** \name Properties */
/**
 * Gets and sets the current rating. Usually only done when setting up.
 */
@property (nonatomic) float rating;

/**
 * Override to return the width of the area on the left which represents a rating of zero.
 */
-(int) calcZeroAreaWidth;

/**
 * Override to return the image for a specific index.
 */
-(UIImage *) imageForIndex:(int) index;

/**
 * Called from DCUIRatingAbstractScaleStrategy:calcNewRatingFromTouchX to do the calculation.
 */
-(float) calcRatingFromTouchX:(int) touchX;

@end
