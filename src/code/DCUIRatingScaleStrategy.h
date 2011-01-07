//
//  DCUIRatingScaleStrategy.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//  

#import <UIKit/UIKit.h>  


/**
 This interface outlines the contract for a class which handles scale
 related functionality for a DCUIRating.
 */
@protocol DCUIRatingScaleStrategy

/// ------------------------------------
/// @name Constructors
/// ------------------------------------

/**
 Primary constructor.
 
 @param aOffImage a UIImage which is displayed when the rating icon index is higher that the rating. i.e. it's off.
 @param aOnImage a UIImage which is displayed when the rating icon index is less than or equal to the rating. i.e. it's on.
 @param aHalfOnImage a UIImage which is displayed when the rating icon index is equal to the rating and the scale is set to DC\_SCALE\_0\_TO\_5\_WITH\_HALVES or DC\_SCALE\_0\_TO\_10. i.e. it's a half a star.
 */
-(id) initWithOffImage:(UIImage *) aOffImage onImage:(UIImage *) aOnImage halfOnImage:(UIImage *) aHalfOnImage;

/// ------------------------------------
/// @name Methods
/// ------------------------------------

/**
 Called during DCUIRating:drawRect:, this is where the strategy is 
 expected to handle drawing the correct image on the display. This method will be called 5 times to draw 
 the complete row of images.
 
 @param index the index of the icon to be drawn. 
 */
-(void) drawImageAtIndex:(int) index;

/**
 Returns the width of the area on the left where the rating is zero.
 */
-(int) calcZeroAreaWidth;

/**
 Asks the strategy to calculate a new rating based on the touch. This is the method that is called by DCUIRating.
 
 @param touchX the current horizontal X value of the touch event.
 */
-(float) calcNewRatingFromTouchX:(int) touchX;

/**
 The current value of the rating as set or calculated by the strategy.
 */
@property (nonatomic) float rating;

/**
 Used to get a formatted version of the rating suitable for displays.
 */
-(NSString *) formattedRating;

@end
