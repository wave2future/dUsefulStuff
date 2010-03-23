//
//  NSDictionary+DC.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

/**
 * This category adds messages to the NSDictionary class to allow calls to dictinary functions using int's as keys.
 */

@interface NSDictionary (dUsefulStuff)

- (id) objectForIntKey:(int)aIntKey;

@end
