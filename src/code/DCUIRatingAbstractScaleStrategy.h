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
 This is an abstract class for strategies. It puts in place everything that all strategies do.
 */
@interface DCUIRatingAbstractScaleStrategy : NSObject <DCUIRatingScaleStrategy> {
	float rating;
	int imageWidth;
	int zeroAreaWidth;
@private
	UIImage * onImage;
	UIImage * offImage;
	UIImage * halfOnImage;
}

/**
 Override to return the width of the area on the left which represents a rating of zero.
 */
-(int) calcZeroAreaWidth;

/**
 Override to return the image for a specific index.
 
 @param index the index of the image we want. 0 - iconCount.
 */
-(UIImage *) imageForIndex:(int) index;

/**
 Called from calcNewRatingFromTouchX: to do the calculation of the new rating. This needs to be implemented
 by the strategies.
 
 @param touchX the horizontal X value from the touch event.
 */
-(float) calcRatingFromTouchX:(int) touchX;

@end
