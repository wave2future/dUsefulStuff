//
//  DCUIRatingScaleStrategy.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//  

#import <UIKit/UIKit.h>  

/**
 * This interface outlines the contract for a class which handles scale
 * related functionality for a DCUIRating.
 */
@protocol DCUIRatingScaleStrategy

/** \name Constructor */
-(id) initWithOffImage:(UIImage *) aOffImage onImage:(UIImage *) aOnImage halfOnImage:(UIImage *) aHalfOnImage;

/** \name Methods */

/**
 * Called during DCUIRating:drawRect, this is where the strategy is 
 * expected to handle drawing the correct image on the display.
 */
-(void) drawImageAtIndex:(int) index;

/**
 * Returns the width of the area on the left where the rating is zero.
 */
-(int) calcZeroAreaWidth;

/**
 * Asks the strategy to calculate a new rating based on the touch.
 */
-(float) calcNewRatingFromTouchX:(int) touchX;

/**
 * Setter which allows setting of the current value.
 */
-(void) setRating:(float) aRating;

/**
 * Getter for the current rating.
 */
-(float) rating;

/**
 * Used to get a formatted version of the rating suitable for displays.
 */
-(NSString *) formattedRating;

@end
