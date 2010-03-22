// Contains use macros which are non-project specific.
//
//  Created by Derek Clarkson on 23/11/09.
//  Copyright 2009 Derek Clarkson. All rights reserved.
//

// Notes:

// 1. The do - while is so that macro defined variables
// have their own scope. This stops definition errors when the macro is used several times in a row.

#pragma mark Logging

/**
 * DC_LOG is controlled by the DHC_DEBUG flag. If set, all DHC_LOG calls are converted into NSLog() calls.
 * If not set they are balnked out, producing no additional code. This makes life easy for developing because we
 * can be quite verbose without worrying about slowing the code down.
 */
#ifdef DC_DEBUG
#define DC_LOG(s, ...) \
   NSLog(@"%@:(%d) %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
         __LINE__, \
         [NSString stringWithFormat:(s), ## __VA_ARGS__])
#else
// Effective remove the logging.
#define DC_LOG(s, ...)
#endif

#pragma mark Memory handling

/**
 * Wraps up some boiler plate code to dealloc an instance of a variable.
 */
#ifdef DC_LOG_DEALLOCS

#define DC_DEALLOC(vName) \
   do { \
		if (vName == nil) { \
			break; \
		} \
		id dobj = (id)vName; \
		if ([dobj retainCount] == INT_MAX) { \
			DC_LOG(@"DC_DEALLOC releasing static " # vName ": %@", dobj); \
			break; \
		} \
		if ([dobj isKindOfClass:[NSData class]]) { \
			NSData *data = dobj;    \
			DC_LOG(@"DC_DEALLOC releasing " # vName ": %@", DC_DATA_TO_STRING(data)); \
			break; \
		} \
		if (![dobj isKindOfClass:[NSDictionary class]] && ![dobj isKindOfClass:[NSArray class]]) { \
			DC_LOG(@"DC_DEALLOC releasing " # vName ": %@", vName); \
			break; \
		} \
	} while (FALSE); \
   if (vName != nil) { \
		[vName release]; \
		vName = nil; \
	}
#else
#define DC_DEALLOC(vName) \
   if (vName != nil) { \
		[vName release]; \
		vName = nil; \
	}
#endif /* ifdef DC_LOG_DEALLOCS */

#pragma mark String handling

// Trims whitespace from a string and returns a new string.
#define DC_TRIM(string) \
   [string stringByTrimmingCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#pragma mark Common conversions

// Converts a boolean to a YES/NO string. Used in logging.
#define DC_PRETTY_BOOL(bool) \
   bool ? @"YES" : @"NO"

// Convert a NSData object to a NSString.
#define DC_DATA_TO_STRING(data) \
   [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]

// Convert a NSString to a NSData.
#define DC_STRING_TO_DATA(string) \
   [string dataUsingEncoding : NSUTF8StringEncoding]

#pragma mark Working with NSDictionarys

/**
 * When the dictionary is indexed using ints, returns the NSDictionary key as an int.
 */
#define DC_NSDICTIONARY_KEY_TO_INT(dic, keyIndex) \
   [(NSNumber *)[[dic allKeys] objectAtIndex:keyIndex] intValue]

/**
 * When a dictionary is indexed using ints, returns the object for a specific key.
 */
#define DC_NSDICTIONARY_OBJ_FOR_INT_KEY(dic, intKey) \
   [dic objectForKey :[NSNumber numberWithInteger:intKey]]

/**
 * When a dictionary is indexed using ints and has int values, returns the value for a key.
 */

#define DC_NSDICTIONARY_INT_FOR_INT_KEY(dic, intKey) \
   [(NSNumber *)DC_NSDICTIONARY_OBJ_FOR_INT_KEY(dic, intKey) intValue]

#pragma mark Testing

// iPhone compatible mock arg define from OCMock. Need to post this to the author.
#define DC_MOCK_VALUE(variable) [NSValue value : &variable withObjCType : @encode(__typeof__(variable))]

