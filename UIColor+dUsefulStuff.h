//
//  NSObject+dUsefulStuff.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 18/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A category of colour handing routines.
 */
@interface UIColor (dUsefulStuff)

/**
 * Returns YES if the colours are the same.
 */
- (BOOL) isEqualToColor:(UIColor *) aColour;

@end
