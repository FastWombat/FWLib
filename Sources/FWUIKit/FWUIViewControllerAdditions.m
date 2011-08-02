//
//  FWUIViewControllerAdditions.m
//  ToastAndTell
//
//  Created by Duane Fields on 3/14/11.
//  Copyright 2011 Demand Media, Inc. All rights reserved.
//

#import "FWUIViewControllerAdditions.h"


FORCE_LINKER_TO_FIND_CATEGORY(FWUIViewControllerAdditions);

@implementation UIViewController (FWUIViewControllerAdditions)

- (id)initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
