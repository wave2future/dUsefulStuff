// Contains use macros which are non-project specific.
//
//  Created by Derek Clarkson on 23/11/09.
//  Copyright 2009 Derek Clarkson. All rights reserved.
//

// Notes:

// 1. The do - while is so that macro defined variables have their own scope. 
// This stops definition errors when the macro is used several times in a row.

#pragma mark Logging

/**
 * DC_LOG is controlled by the DHC_DEBUG flag. If set, all DHC_LOG calls are converted into NSLog() calls.
 * If not set they are blanked out, producing no additional code. This makes life easy for developing because we
 * can be quite verbose without worrying about slowing the code down.
 */
#ifdef DC_DEBUG

#define DC_LOG(s, ...) \
   NSLog(@"%@:(%d) %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
         __LINE__, \
         [NSString stringWithFormat:(s), ## __VA_ARGS__])

#define DC_LOG_LAYOUT(obj) \
	do { \
		UIView *_dObj = (UIView *) obj; \
		NSLog(@"%@:(%d) Layout for \"" # obj "\" position= %i x %i, size= %i x %i", \
			[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
			__LINE__, \
			(int)_dObj.frame.origin.x, (int)_dObj.frame.origin.y, (int)_dObj.frame.size.width, (int)_dObj.frame.size.height); \
	} while (FALSE);
#else

// Effectively remove the logging.
#define DC_LOG(s, ...)
#define DC_LOG_LAYOUT(obj)

#endif

#pragma mark Memory handling

/**
 * Wraps up some boiler plate code to dealloc an instance of a variable. This just does some house keeping
 * Although if logging is on, it will attempt to print a representation of the value of the deallocd variable so
 * that the developer can see when things are being freed.
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
		if ([vName retainCount] == 0) { \
			DC_LOG(@"ERROR !!!!! " # vName " retain count == 0") \
		} \
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

#pragma mark Testing

// iPhone compatible mock arg define from OCMock. Need to post this to the author.
#define DC_MOCK_VALUE(variable) [NSValue value : &variable withObjCType : @encode(__typeof__(variable))]

