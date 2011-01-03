//
//  NSObject+dUsefulStuff.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 18/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A category of colour handing routines.
 */
@interface UIColor (dUsefulStuff)

/**
 Returns YES if this colour is the same as the colour passed in this message.
 
 @param aColour the colour to test against. 
 */
- (BOOL) isEqualToColor:(UIColor *) aColour;

@end
