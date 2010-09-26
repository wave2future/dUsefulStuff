//
//  NSObject+dUsefulStuff.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 18/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "UIColor+dUsefulStuff.h"
#import "DCCommon.h"

@implementation UIColor (dUsefulStuff)

- (BOOL) isEqualToColor:(UIColor *) aColour {
	DC_LOG(@"First CGColour : %@", self.CGColor);
	DC_LOG(@"Second CGColour: %@", aColour.CGColor);
	return CGColorEqualToColor(self.CGColor, aColour.CGColor);
}
@end
