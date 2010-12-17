//
//  DCCoreDataTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/23/10.
//  Copyright 2010 Oakton Pty Ltd. All rights reserved.
//

#import <GHUnitIOS/GHUnitIOS.h>

#import "DCCoreData.h"

@interface DCCoreDataTests : GHTestCase {}

@end


@implementation DCCoreDataTests

-(void) testInstantiating {
	NSError * error = nil;
	DCCoreData * cData = [[[DCCoreData alloc] initWithDBName:@"abc" error:&error] autorelease];
	GHAssertNotNil(cData, @"Nill object returned.");
	GHAssertNil(error, @"Error object present");
	
	//Validate that the file exists.
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
	GHAssertTrue([fileManager fileExistsAtPath:cData.dbFilePath], @"Database file not found");

	//Validate other properties.
	GHAssertEqualStrings(@"abc", cData.dbName, @"Correct dbname not returned");
	GHAssertNotNil(cData.managedObjectContext, @"ManagedObjectContet is nil");
}

-(void) testInstantiatingWithAnError {
	
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *dbFilePath = [docDir stringByAppendingPathComponent:@"test.sqlite"];
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
	NSError * error = nil;
	[fileManager createDirectoryAtPath:dbFilePath withIntermediateDirectories:YES attributes:nil error:&error];
	GHAssertNil(error, @"Error object not present");
	
	DCCoreData * cData = [[[DCCoreData alloc] initWithDBName:@"test" error:&error] autorelease];
	GHAssertNil(cData, @"Object returned when nil expected.");
	GHAssertNotNil(error, @"Error object not present");
}

@end
