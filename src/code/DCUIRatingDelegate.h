//
//  DCUIRatingDelegate.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 11/26/10.
//  Copyright 2010 Oakton Pty Ltd. All rights reserved.
//

// Use @class here due to circular reference with DCUIRating.
@class DCUIRating;

/**
 * Implement this protocol on a class to receive notifications from the rating control.
 */
@protocol DCUIRatingDelegate
@optional
/**
 * Sent by the DCUIRating control any time the rating value is changed.
 */
-(void) ratingDidChange:(DCUIRating *) rating;

@end
