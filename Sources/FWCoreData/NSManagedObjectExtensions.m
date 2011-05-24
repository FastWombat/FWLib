#import "NSManagedObjectExtensions.h"

FORCE_LINKER_TO_FIND_CATEGORY(NSManagedObjectExtensions);

@implementation NSManagedObject (Extensions)

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context {
	NSString *className = NSStringFromClass([self class]);
	NSEntityDescription* entityDescription = [NSEntityDescription entityForName:className inManagedObjectContext:context];
	NSAssert1(entityDescription, @"Entity description should not be null for class %@", className);
	return entityDescription;
}

+ (NSFetchRequest *)fetchRequestTemplateForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context {
	return [[[self entityInManagedObjectContext:context] managedObjectModel] fetchRequestTemplateForName:name];
}

+ (NSFetchRequest *)fetchRequestFromTemplateWithName:(NSString *)name substitutionVariables:(NSDictionary *)variables inManagedObjectContext:(NSManagedObjectContext *)context {
	return [[[self entityInManagedObjectContext:context] managedObjectModel] fetchRequestFromTemplateWithName:name substitutionVariables:variables];
}

+ (NSArray *) fetchWithTemplateWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext*)context {
	NSFetchRequest* fetchRequest = [self fetchRequestTemplateForName:name inManagedObjectContext:context];
	
	NSError* error = nil;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	if (error != nil) {
		[NSException raise:NSGenericException format:@"%@", [error description]];
	}
	
	return results;	
}


+ (NSFetchRequest *)fetchRequestWithPredicate:(id)stringOrPredicate withSortDescriptors:(NSArray*)sortDescriptors inManagedObjectContext:(NSManagedObjectContext*)context {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [self entityInManagedObjectContext:context];
	
	// allows you to pass both predicates, and strings that we treat as predicates
	if (stringOrPredicate) {
        NSPredicate *predicate = nil;
        if ([stringOrPredicate isKindOfClass:[NSString class]]) {
            predicate = [NSPredicate predicateWithFormat:stringOrPredicate];
        }
        else {
            NSAssert2([stringOrPredicate isKindOfClass:[NSPredicate class]],
					  @"Second parameter passed to %s is of unexpected class %@",
					  sel_getName(_cmd), NSStringFromClass([stringOrPredicate class]));
            predicate = (NSPredicate *)stringOrPredicate;
        }
		fetchRequest.predicate = predicate;
    }
	
	// setup sort descriptors
	if (sortDescriptors != nil && sortDescriptors.count > 0) {
		fetchRequest.sortDescriptors = sortDescriptors;
	}	
	
	return [fetchRequest autorelease];
}	


+ (NSFetchRequest *)fetchRequestWithPredicate:(id)stringOrPredicate withSortKey:(NSString *)keyPath ascending:(BOOL)ascending inManagedObjectContext:(NSManagedObjectContext*)context {
	// setup sort descriptors
	NSMutableArray* sortDescriptors = nil;
	if (keyPath != nil) {
		sortDescriptors = [NSMutableArray array];
		NSArray* sortKeys = [keyPath componentsSeparatedByString:@","];
		for (NSString* sortKey in sortKeys) {
			//can't use sortDescriptorWithKey: until we drop 3.1 support
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
			[sortDescriptors addObject:sortDescriptor];
			FWRelease(sortDescriptor);
		}
	}	
	
	return [self fetchRequestWithPredicate:stringOrPredicate withSortDescriptors:sortDescriptors inManagedObjectContext:context];
}	


+ (id)insertNewObjectInManagedContext:(NSManagedObjectContext *)context {
	NSString *className = NSStringFromClass([self class]);
	return [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
}

+ (NSArray *)executeFetchRequest:(NSFetchRequest*)fetchRequest inManagedObjectContext:(NSManagedObjectContext*)context {
	NSError *error = nil;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	if (error != nil) {
		[NSException raise:NSGenericException format:@"%@", [error description]];
	}
	
	return results;
}

+ (id)fetchSingleEntityWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context {
	NSArray* results = [self fetchWithPredicate:stringOrPredicate withSortKey:nil ascending:YES inManagedObjectContext:context];
    if ([results count] > 0)
        return [results objectAtIndex:0];
    return nil;
}

+ (NSArray *)fetchWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context {
	return [self fetchWithPredicate:stringOrPredicate withSortKey:nil ascending:YES inManagedObjectContext:context];
}

+ (NSFetchRequest *)fetchRequestWithPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context {
	return [self fetchRequestWithPredicate:stringOrPredicate withSortKey:nil ascending:YES inManagedObjectContext:context];
}

+ (NSUInteger)countForPredicate:(id)stringOrPredicate inManagedObjectContext:(NSManagedObjectContext*)context {
	NSFetchRequest* fetchRequest = [self fetchRequestWithPredicate:stringOrPredicate withSortKey:nil ascending:YES inManagedObjectContext:context];
	NSError *error = nil;
	NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
	if (error != nil) {
		[NSException raise:NSGenericException format:@"%@", [error description]];
	}
	return count;
}

+ (NSArray *)fetchWithPredicate:(id)stringOrPredicate withSortKey:(NSString *)keyPath ascending:(BOOL)ascending inManagedObjectContext:(NSManagedObjectContext*)context {
	NSFetchRequest* fetchRequest = [self fetchRequestWithPredicate:stringOrPredicate withSortKey:keyPath ascending:ascending inManagedObjectContext:context];
	NSError *error = nil;
	NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
	if (error != nil) {
		[NSException raise:NSGenericException format:@"%@", [error description]];
	}

	return results;	
}

+ (id)objectWithID:(NSManagedObjectID*)managedObjectId inManagedObjectContext:(NSManagedObjectContext*)context {
	return [context objectWithID:managedObjectId];
}

+ (NSArray*)objectsWithIDs:(NSArray*)managedObjectIds inManagedObjectContext:(NSManagedObjectContext*)context {
	NSMutableArray* objects = [NSMutableArray array];
	// TODO: is there a more efficient way?
	for (NSManagedObjectID* managedObjectId in managedObjectIds) {
		[objects addObject:[context objectWithID:managedObjectId]];
	}

	NSAssert([objects count] == [managedObjectIds count], @"lengths did not match");	
	return objects;
}

@end
