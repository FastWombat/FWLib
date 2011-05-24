#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#if TARGET_OS_IPHONE

@interface NSFetchedResultsController (NSFetchedResultsControllerExtensions)
// a save that throws exceptions if anything goes wrong
- (BOOL)performFetch;
@end

#endif