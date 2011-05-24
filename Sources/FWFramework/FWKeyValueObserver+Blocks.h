//
//  FTZKeyValueObserver.h
//  RangeBD
//
//  Created by Frédéric Testuz on 01.06.10.
//  Copyright 2010 . All rights reserved.
//


@interface NSObject (FWKeyValueObserver_Blocks)

/*
 Call ftz_addObserverForKeyPath:options:queue:usingBlock: with nil for queue
 */
- (id)addObserverForKeyPath:(NSString *)keyPath
						options:(NSKeyValueObservingOptions)options
					 usingBlock:(void(^)(NSObject *, NSDictionary *))block;


/* 
 ftz_addObserverForKeyPath:options:queue:usingBlock: return a new object for observing the caller.
 keyPath and options are the same arguments as in addObserver:forKeyPath:options:context:
 If queue is specified, block will be executed in the queue context
 The two arguments of block are the same as in observeValueForKeyPath:ofObject:change:context:
 
 It's the caller responsability to keep alive the return object as long as necessary.
 It's the caller responsability to call removeObserver:forKeyPath: with the return object as argument
 when it no longer needs to observe.
 */
- (id)addObserverForKeyPath:(NSString *)keyPath
						options:(NSKeyValueObservingOptions)options
						  queue:(NSOperationQueue *)queue
					 usingBlock:(void (^)(NSObject *, NSDictionary *))block;

@end
