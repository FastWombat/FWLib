// The +MCProperties method uses the Objective-C runtime to discover and iterate over properties in the class definition, including @dynamic properties
// that were created at runtime. Because the property runtime calls do not include properties inherited from parent classes, the method acts recursively,
// iterating up the object hierarchy until it gets to NSManagedObject. The actual -description method simply prints out each of the attributes and the
// value currently stored for that attribute for this object instance. Once you do this, if you use NSLog() or po, the result is much richer information
// about the objects getting printed to the console. This version ignores relationships and fetched properties, but it wouldn't be hard to add those
// in if you needed them.

#import <objc/runtime.h>

FORCE_LINKER_TO_FIND_CATEGORY(DebugProperties);

#if DEBUG
@implementation NSObject(DebugProperties)

+ (NSMutableArray *)DebugProperties {
    NSMutableArray *properties = nil;
    
    if ([self superclass] != [NSManagedObject class])
        properties = [[self superclass] DebugProperties];
    else
        properties = [NSMutableArray array];
    
    
    unsigned int propCount;
    objc_property_t * propList = class_copyPropertyList([self class], &propCount);
    int i;
    
    for (i=0; i < propCount; i++) {
        objc_property_t oneProp = propList[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(oneProp)];
        if (![properties containsObject:propName])
            [properties addObject:propName];
    }

    return properties;
}

@end

@implementation NSManagedObject(DebugProperties)

- (NSString *)description {
    NSArray *properties = [[self class] DebugProperties];
    NSMutableString *ret = [NSMutableString stringWithFormat:@"%@:", NSStringFromClass([self class])];
    NSDictionary *myAttributes = [[self entity] attributesByName];
    
    for (NSString *oneProperty in properties) {
        NSAttributeDescription *oneAttribute = [myAttributes valueForKey:oneProperty];
        if (oneAttribute != nil) { // If not, it's a relationship or fetched property
            id value = [self valueForKey:oneProperty];
            [ret appendFormat:@"\n\t%@ = %@", oneProperty, value];
        }		
    }

    return ret;
}

@end

#endif


