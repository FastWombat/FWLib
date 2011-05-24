#import "NSFetchedResultsControllerExtensions.h"

FORCE_LINKER_TO_FIND_CATEGORY(NSFetchedResultsControllerExtensions);

#if TARGET_OS_IPHONE

@implementation NSFetchedResultsController (NSFetchedResultsControllerExtensions)

- (BOOL)performFetch {
    NSError *error = nil;
	BOOL success = [self performFetch:&error];
    if (error != nil) {
        [NSException raise:NSGenericException format:@"%@", [error description]];
    }
	return success;
}

@end

#endif