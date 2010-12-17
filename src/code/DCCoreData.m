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

@end


@implementation DCCoreData

@synthesize managedObjectContext;
@synthesize dbName;
@synthesize dbFilePath;

- (id) initWithDBName:(NSString *)aName error:(NSError **) error {
	self = [super init];
	if (self) {

		dbName = [aName retain];
		NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
		dbFilePath = [docDir stringByAppendingPathComponent:[dbName stringByAppendingString:@".sqlite"]];
		NSURL *dbFileUrl = [NSURL fileURLWithPath:dbFilePath];
		DC_LOG(@"Using database at path: %@", dbFilePath);

		DC_LOG(@"Creating managed object model from all models in the app bundle.");
		managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];

		DC_LOG(@"Create persistant store coordinator");
		persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

		DC_LOG(@"Adding database to persistant store.");
		if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbFileUrl options:nil error:error]) {
			return nil;
		}
		
		DC_LOG(@"Creating managed object context.");
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[self.managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];

	}
		
	return self;
}

- (BOOL) deleteDatabase:(NSError **) error {
	NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
	DC_LOG(@"Checking for database file at: %@", self.dbFilePath);
	if ([fileManager fileExistsAtPath:self.dbFilePath]) {
		DC_LOG(@"Deleting database: %@", self.dbFilePath);
		return [fileManager removeItemAtPath:self.dbFilePath error:error];
	}
	return YES;
}


- (void) dealloc {
	DC_DEALLOC(dbName);
	DC_DEALLOC(managedObjectModel);
	DC_DEALLOC(persistentStoreCoordinator);
	DC_DEALLOC(managedObjectContext);
	[super dealloc];
}

@end
