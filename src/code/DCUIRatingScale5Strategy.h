//
//  DCUIRatingScale5Strategy.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUIRatingScaleStrategy.h"

@interface DCUIRatingScale5Strategy : NSObject <DCUIRatingScaleStrategy> {
	UIImage * onImage;
	UIImage * offImage;
	UIImage * halfOnImage;
	float rating;
	int imageWidth;
	float fuzzFactor;
}

@end
