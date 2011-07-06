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
 DC_LOG is controlled by the DHC_DEBUG flag. If set, all DHC_LOG calls are converted into NSLog() calls.
 If not set they are blanked out, producing no additional code. This makes life easy for developing because we
 can be quite verbose without worrying about slowing the code down.
 */
#ifdef DC_DEBUG

#define DC_LOG(s, ...) \
   NSLog(@"%s(%d) %@", __PRETTY_FUNCTION__, \
         __LINE__, \
         [NSString stringWithFormat:(s), ## __VA_ARGS__])

#define DC_LOG_LAYOUT(obj) \
	do { \
		NSString * msg = [NSString stringWithFormat:@"%@:(%d) Layout for \"" # obj "\"", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__]; \
		DC_LOG_CGRECT(msg, obj.frame); \
	} while (FALSE);

#define DC_LOG_CGRECT(msg, obj) \
	do { \
	NSLog(@"%@ position= %i x %i, size= %i x %i", \
		msg, (int) obj.origin.x, (int)obj.origin.y, (int)obj.size.width, (int)obj.size.height); \
	} while (FALSE);

#else

// Effectively remove the logging.
#define DC_LOG(s, ...)
#define DC_LOG_LAYOUT(obj)
#define DC_LOG_CGRECT(msg, obj)

#endif

#pragma mark Memory handling

/**
 Wraps up some boiler plate code to dealloc an instance of a variable. This just does some house keeping
 Although if logging is on, it will attempt to print a representation of the value of the deallocd variable so
 that the developer can see when things are being freed.
 */
#ifdef DC_LOG_DEALLOCS

#define DC_DEALLOC(vName) \
	if (vName == nil) { \
		DC_LOG(@"DC_DEALLOC " # vName " is nil, nothing to do."); \
	} else { \
		\
		id dobj = (id)vName; \
		\
		/* If it's static then do nothing. */ \
		if ([dobj retainCount] == INT_MAX) { \
			DC_LOG(@"DC_DEALLOC static " # vName ": %@", dobj); \
		} else {  \
			\
			/* Print details. */ \
			if ([dobj isKindOfClass:[NSData class]]) { \
				NSData *data = dobj;    \
				DC_LOG(@"DC_DEALLOC NSData " # vName ": %@", DC_DATA_TO_STRING(data)); \
			} else if (![dobj isKindOfClass:[NSDictionary class]] && ![dobj isKindOfClass:[NSArray class]]) { \
				DC_LOG(@"DC_DEALLOC " # vName ": %@", vName); \
			} \
			\
			/* Now release. */ \
			DC_LOG(@"DC_DEALLOC Releasing " # vName " ([%p] retain count: %i)", vName ,[vName retainCount]); \
			[vName release]; \
			vName = nil; \
		} \
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

// Internal macro - don't use.
#define _DC_CONCAT(left, right) left ## right

// Concantiates the two values using another macro to do the work. This allows a level of indirection which
// means that macros such as __LINE__ can be concatinated.
#define DC_CONCATINATE(left, right) _DC_CONCAT(left, right)

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

