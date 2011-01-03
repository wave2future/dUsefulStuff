//
//  NSMutableDictionary+DCIntKey.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

/**
 Category providing extensions to the NSMutableDictionary class.
 */
@interface NSMutableDictionary (dUsefulStuff)

/**
 Stores an object for an int key.
 
 @param anObject the object to be stored.
 @param aIntKey the int key to store it at.
 */
- (void) setObject:(id)anObject forIntKey:(int)aIntKey;

@end
