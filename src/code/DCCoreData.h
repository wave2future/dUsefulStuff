//
// CoreData.h
// Crema
//
// Created by Derek Clarkson on 15/05/10.
// Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
   This class acts as a wrapper to core data. It's job is to simply the calls being made so that the rest of
   the application doesn't have to be too aware of core data's internals.
 */
@interface DCCoreData : NSObject {
	@private
	NSString * dbName;
	NSString * dbFilePath;
	NSManagedObjectModel * managedObjectModel;
	NSManagedObjectContext * managedObjectContext;
	NSPersistentStoreCoordinator * persistentStoreCoordinator;
}

/** @name Properties */

/**
   Gives access to the managed object context.
 */
@property (nonatomic, readonly) NSManagedObjectContext * managedObjectContext;

/**
   Returns the name of the database.
 */
@property (nonatomic, readonly) NSString * dbName;

/**
   Returns the url of the database in the local file system.
 */
@property (nonatomic, readonly) NSString * dbFilePath;

/** @name Constructors */
/** Constructor which accepts the name of the sqlite database that will be used. This assembles all the interal objects in order to work with that database.

   @param nName the name of the database to create/access.
   @param error a reference to an error variable which will be populated with a NSError object if there is a problem.
   @return a reference to the newly created DCCoreData instance.
 */
- (id) initWithDBName:(NSString *) aName error:(NSError **) error;

/**
   Deletes the database by deleting the file it is stored in.

   @param error a reference to an error variable which will be populated with a NSError object if there is a problem.
   @return YES if the deletion was successful. NO otherwise.
 */
- (BOOL) deleteDatabase:(NSError **) error;

@end
