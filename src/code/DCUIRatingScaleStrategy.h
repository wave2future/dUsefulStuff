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
/// @name Properties
/// ------------------------------------

/**
 The image used when a rating is equal to or less than the index of the icon.
 */
@property (nonatomic, retain) UIImage * onImage;

/**
 The image used when a rating is greater than the index of the icon.
 */
@property (nonatomic, retain) UIImage * offImage;

/**
 The image used when a rating is half way across the icon.
 */
@property (nonatomic, retain) UIImage * halfOnImage;

/// ------------------------------------
/// @name Messages
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
