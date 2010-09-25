//
//  CoreData.h
//  Crema
//
//  Created by Derek Clarkson on 15/05/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 * This class acts as a wrapper to core data. It's job is to simply the calls being made so that the rest of
 * the application doesn't have to be too aware of core data's internals.
 */
@interface DCCoreData : NSObject {
	@private
	NSString *dbName;
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

/** \name Properties */
/**
 * Gives access to the managed object context.
 */
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

/** \name Constructors */
/**
 * Constructor which accepts the name of the sqlite database that will be used. This assembles all the interal objects in order to work with that database.
 */
- (id) initWithDBName:(NSString *)aName;

/** \name Finalisation */
/**
 * Call this from your application delegate to ensure correct shutdown. This ensures that any changes left in the managed object context are saved to the database.
 */
- (void) applicationWillTerminate;

@end
