#import "FWUITableViewCell.h"

@implementation FWUITableViewCell

+ (NSString*)reuseIdentifier {
	return NSStringFromClass([self class]);
}

static id __nibCache = nil;
+ (void)initialize {
	[super initialize];
	if (__nibCache == nil) {
		Class NSCacheClass = NSClassFromString(@"NSCache");
		__nibCache = [[NSCacheClass alloc] init];
	}
}

+ (id)cell {
	FWUITableViewCell* cell = [self allocWithNibName:nil];
	return [cell autorelease];
}

+ (id)allocWithNibName:(NSString *)nibName {
	// default to name of class
	if (nibName == nil) {
		nibName = NSStringFromClass([self class]);
	}
	
	// we cache the nibs for faster creation time, if supported (4.0 only)
	NSArray* topLevelObjects = nil;
	Class UINibClass = NSClassFromString(@"UINib");
	if (UINibClass) {
#ifdef __IPHONE_4_0
		id aNib = [__nibCache objectForKey:nibName];
		
		// not there, so load and cache
		if (aNib == nil) {
			FWLog(@"Loading custom tableviewcell from uncached NIB: %@.xib", nibName);
			aNib = [UINibClass nibWithNibName:NSStringFromClass([self class]) bundle:nil];
			[__nibCache setObject:aNib forKey:nibName];
		} else {
			FWLog(@"Loading custom tableviewcell via cached NIB: %@.xib", nibName);
		}
		
		// load the top level objects
		NSAssert(aNib != nil, @"Failed to load the nib");
		topLevelObjects = [aNib instantiateWithOwner:nil options:nil];
#endif
	} else {
		// 3.X version, loads from the nib without caching
		topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	}
	NSAssert(topLevelObjects, @"failed to load objects from the nib");
	
	// the first top level object in the nib is the cell
	UITableViewCell* cell = [topLevelObjects objectAtIndex:0];
	
	// make sure it's what we think it is
	NSAssert([cell class] == [self class], @"NIB did not contain the proper type of tableviewcell");
	
	// reuse identifier should be the same as our class identifier
	NSAssert1([cell.reuseIdentifier isEqualToString:[[self class] reuseIdentifier]], @"cell reuse identifier must be set to %@ in nib", [[self class] reuseIdentifier]);
	
	return (id)[cell retain];
}

@end

