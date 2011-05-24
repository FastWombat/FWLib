//
//  FTZKeyValueObserver.m
//  RangeBD
//
//  Created by Frédéric Testuz on 01.06.10.
//  Copyright 2010 . All rights reserved.
//

#import "FWKeyValueObserver+Blocks.h"


@interface FWKeyValueObserver : NSObject
{
	NSOperationQueue *queue;
	void (^observingBlock)(NSObject *object, NSDictionary *change);
}

- (id)initObserverForObservee:(id)observee
					  keyPath:(NSString *)keyPath
					  options:(NSKeyValueObservingOptions)options
						queue:(NSOperationQueue *)aQueue
				   usingBlock:(void(^)(NSObject *, NSDictionary *))block;

@end


@implementation NSObject (FWKeyValueObserver_Blocks) 

- (id)addObserverForKeyPath:(NSString *)keyPath
						options:(NSKeyValueObservingOptions)options
					 usingBlock:(void(^)(NSObject *, NSDictionary *))block
{
	return [self addObserverForKeyPath:keyPath
								   options:options
									 queue:nil
								usingBlock:block];
}

- (id)addObserverForKeyPath:(NSString *)keyPath
						options:(NSKeyValueObservingOptions)options
						  queue:(NSOperationQueue *)queue
					 usingBlock:(void(^)(NSObject *, NSDictionary *))block
{	
	FWKeyValueObserver *observer = [[FWKeyValueObserver alloc] initObserverForObservee:self
																				 keyPath:keyPath
																				 options:options
																				   queue:queue
																			  usingBlock:block];
	return [observer autorelease];
}

@end

@implementation FWKeyValueObserver

static int ftzKVOContext = 0;

- (id)initObserverForObservee:(id)observee
					  keyPath:(NSString *)keyPath
					  options:(NSKeyValueObservingOptions)options
						queue:(NSOperationQueue *)aQueue
				   usingBlock:(void(^)(NSObject *, NSDictionary *))block
{
	self = [super init];
	if (self != nil) {
		queue = [aQueue retain];
		observingBlock = [block copy];
		[observee addObserver:self
				   forKeyPath:keyPath
					  options:options
					  context:&ftzKVOContext];
	}
	return self;
}

- (void)dealloc
{
	[observingBlock release];
	[queue release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
    if (context == &ftzKVOContext) {
		if (queue == nil) {
			observingBlock(object, change);
		}
		else {
			[queue addOperationWithBlock:^{
				observingBlock(object, change);
			}];
		}
	}
	else {
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
	}
}

@end

