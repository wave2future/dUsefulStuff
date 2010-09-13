//
//  CoreData.m
//  Crema
//
//  Created by Derek Clarkson on 15/05/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCDialogs.h"
#import "DCCoreData.h"
#import "DCCommon.h"

@interface DCCoreData ()

- (NSManagedObjectModel *) managedObjectModel;
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator;

@end


@implementation DCCoreData

@dynamic managedObjectContext;

/**
 * Constructor which takes a directory to look for the database in.
 */
- (id) initWithDBName:(NSString *)aName {
	self = [super init];
	if (self) {
		dbName = [aName retain];
	}
	return self;
}

/**
 * Returns the managed object context for the application.
 * If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {

	if (managedObjectContext != nil) {
		return managedObjectContext;
	}

	DC_LOG(@"Create managed object context");
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return managedObjectContext;
}


/**
 * Returns the managed object model for the application.
 * If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *) managedObjectModel {

	if (managedObjectModel != nil) {
		return managedObjectModel;
	}
	DC_LOG(@"Creating managed object model");
	managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	return managedObjectModel;
}


/**
 * Returns the persistent store coordinator for the application.
 * If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

	if (persistentStoreCoordinator != nil) {
		return persistentStoreCoordinator;
	}

	DC_LOG(@"Create persistant store coordinator");
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSURL *storeUrl = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:[dbName stringByAppendingString:@".sqlite"]]];

	NSError *error = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);

		//Alert the user
		NSString * msg = [[NSString alloc] initWithFormat:
				 @"An unexpected error has occured: %@", [error localizedDescription]];
		[DCDialogs displayMessage:msg];
		[msg release];
	}

	return persistentStoreCoordinator;
}

- (void) applicationWillTerminate {
	DC_LOG(@"Terminating");
	NSError *error = nil;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			DC_LOG(@"Unresolved error %@, %@", error, [error userInfo]);
		}
	}
	NSString *msg = [[NSString alloc] initWithFormat:
			 @"An unexpected error has occured: %@", [error localizedDescription]];
	[DCDialogs displayMessage:msg];
	[msg release];
}



- (void) dealloc {
	DC_DEALLOC(dbName);
	[managedObjectContext release];
	[managedObjectModel release];
	[persistentStoreCoordinator release];
	[super dealloc];
}

@end
