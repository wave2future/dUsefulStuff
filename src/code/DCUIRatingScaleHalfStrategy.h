//
//  DCUIRatingScale5HalfStrategy.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/4/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUIRatingAbstractScaleStrategy.h"

/**
 Class that implements the 0, 0.5, 1.0, 1.5 ...5 strategory for DC_SCALE_0_TO_5_WITH_HALVES
 */
@interface DCUIRatingScaleHalfStrategy : DCUIRatingAbstractScaleStrategy {

	/**
	 This formatter is used by decendants as well. Hence it is public.
	 It should not be used by external classes.
	 */
	NSNumberFormatter * decimalFormatter;
}

@end
