#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NSManagedObjectContext (NSManagedObjectContextExtensions)
// helper 
- (NSArray *)fetchObjectsForEntityName:(NSString *)newEntityName withPredicate:(id)stringOrPredicate, ...;

// a save that throws exceptions if anything goes wrong
- (BOOL)save;

// an execute that throws exceptions if anything goes wrong
- (NSArray*)executeFetchRequest:(NSFetchRequest *)request;

@end
