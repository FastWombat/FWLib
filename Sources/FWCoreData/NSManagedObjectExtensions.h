#import <CoreData/CoreData.h>

@interface NSManagedObject (Extensions)

// return the entity description (for a concrete subclass of NSManagedObject)
+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context;

// return a fetch request from a template (for a concrete subclass of NSManagedObject)
+ (NSFetchRequest *) fetchRequestTemplateForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

// fetch using a named template
+ (NSArray *) fetchWithTemplateWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext*)context;

// return a fetch request from a template, with variables (for a concrete subclass of NSManagedObject)
+ (NSFetchRequest *) fetchRequestFromTemplateWithName:(NSString *)name substitutionVariables:(NSDictionary *)variables inManagedObjectContext:(NSManagedObjectContext *)context;

// returns a fetch request with the specified predicate
+ (NSFetchRequest *) fetchRequestWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context;

// returns the count only for a specified predicate
+ (NSUInteger)countForPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context;

// returns a fetch request with the specified predicate and sort criteria (multiple fields with commas)
+ (NSFetchRequest *) fetchRequestWithPredicate:(id)stringOrPredicate withSortKey:(NSString *)keyPath ascending:(BOOL)ascending inManagedObjectContext:(NSManagedObjectContext*)context;

// creates, configures, and returns a new autoreleased instance of the class for the entity (for a concrete subclass of NSManagedObject)
+ (id)insertNewObjectInManagedContext:(NSManagedObjectContext *)context;

// performs a simple predicate search (for a concrete subclass of NSManagedObject)
+ (NSArray *) fetchWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context;

// performs a simple predicate search (for a concrete subclass of NSManagedObject) returning a single object, or nil if none found
+ (id)fetchSingleEntityWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context;

// performs a simple predicate search (for a concrete subclass of NSManagedObject) with sorting
+ (NSArray *) fetchWithPredicate:(id)stringOrPredicate withSortKey:(NSString *)keyPath ascending:(BOOL)ascending inManagedObjectContext:(NSManagedObjectContext*)context;

// more generic, allows you to specify sort descriptors
+ (NSFetchRequest *)fetchRequestWithPredicate:(id)stringOrPredicate withSortDescriptors:(NSArray*)sortDescriptors inManagedObjectContext:(NSManagedObjectContext*)context;

+ (NSFetchRequest *) fetchRequestWithPredicate:(id)stringOrPredicate withSortKey:(NSString *)keyPath ascending:(BOOL)ascending inManagedObjectContext:(NSManagedObjectContext*)context;

+ (NSArray *)executeFetchRequest:(NSFetchRequest*)fetchRequest inManagedObjectContext:(NSManagedObjectContext*)context;

// fetch an object by its ID
+ (id)objectWithID:(NSManagedObjectID*)managedObjectId inManagedObjectContext:(NSManagedObjectContext*)context;

// converts an array of object IDs into objects
+ (NSArray*)objectsWithIDs:(NSArray*)managedObjectIds inManagedObjectContext:(NSManagedObjectContext*)context;

@end
