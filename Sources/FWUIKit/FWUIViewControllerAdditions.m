//
//  FWUIViewControllerAdditions.m
//  ToastAndTell
//
//  Created by Duane Fields on 3/14/11.
//

#import "FWUIViewControllerAdditions.h"


FORCE_LINKER_TO_FIND_CATEGORY(FWUIViewControllerAdditions);

@implementation UIViewController (FWUIViewControllerAdditions)

- (id)initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
