// a same-syntax replacement for FWLog that can be compiled out, and doesn't have timestamp
// FWLog uses NSString strings and FWLog is c-strings
#ifdef DEBUG
#define FWTrace()		 fprintf(stderr, "%s\n", __PRETTY_FUNCTION__)
#define FWLog(fmt, ...)  fprintf(stderr, "%s: %s\n", __PRETTY_FUNCTION__, [[NSString stringWithFormat:(fmt), ## __VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding])
#define FWCLog(fmt, ...) fprintf(stderr, "%s: ", __PRETTY_FUNCTION__); fprintf(stderr, fmt, ## __VA_ARGS__); fprintf(stderr, "\n")
#else
#define FWLog(fmt, ...)
#define FWCLog(fmt, ...)
#define FWTrace()
#endif

// radians / degrees
#define DEG2RAD(degrees)	((degrees) * M_PI / 180)
#define RAD2DEG(radians)	((radians) * 180 / M_PI)

// memory management helpers
#define FWRelease(pointer)	[pointer release], pointer = nil;

// pass in a hex color like UIColorFromRGB(0x528E68)
#define FWUIColorFromRGB(rgbValue) [UIColor \
	colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
	green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
	blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// async helpers
#define BACKGROUND_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MAIN_QUEUE dispatch_get_main_queue()

#define NIL_FOR_NULL(value) (value == [NSNull null] ? nil : value)
#define NULL_FOR_NILL(value) (value == nil ? [NSNull null] : value)

// add this decleration to any file which only defines a category to prevent the linker from stripping them out, obviates force_load, all_load
#define FORCE_LINKER_TO_FIND_CATEGORY(name)@interface FORCE_LINKER_TO_FIND_CATEGORY##name;@end@implementation FORCE_LINKER_TO_FIND_CATEGORY##name;@end