//
//  GHUnitTest+DCUIRatingScaleUtils.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/5/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GHUnit/GHUnit.h>
#import "DCUIRating.h"

// Done as defines because an enum is illegal here.
#define IMAGE_ON 1
#define IMAGE_HALF_ON 0
#define IMAGE_OFF -1

@interface GHTestCase (GHUnitTest_DCUIRatingFixtures)
-(void) verifyImagesDrawAtCorrectPostionWithRating:(float) rating scaleType:(DCRATINGSCALE) scale imageTypes:(int[5]) imageTypes iconCount:(int) iconCount;
@end
