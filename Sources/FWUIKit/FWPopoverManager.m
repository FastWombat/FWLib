//
//  FWPopupManager.m
//  CalorieTracker
//
//  Created by Duane Fields on 9/1/11.
//  Copyright 2011 Fast Wombat, LLC All rights reserved.
//

#import "FWPopoverManager.h"

@implementation FWPopoverManager
@synthesize currentPopoverController = _currentPopoverController;

+ (FWPopoverManager*)defaultManager {
    static FWPopoverManager* defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[FWPopoverManager alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:defaultManager selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    });
    
    return defaultManager;
}

- (UIPopoverController*)popoverControllerWithContentViewController:(UIViewController*)viewController {
    // release any existing popover, it will be freed on dismissal
    [_currentPopoverController dismissPopoverAnimated:YES];
    
    _currentPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
    _currentPopoverController.delegate = self;

    return _currentPopoverController;
}

- (void)orientationDidChange:(id)notification {
	[self.currentPopoverController dismissPopoverAnimated:NO];
}


#pragma mark UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    popoverController.delegate = nil;
    if (popoverController == _currentPopoverController) {
        FWRelease(_currentPopoverController);
    }
    else {
        FWRelease(popoverController);
    }
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    _currentPopoverController.delegate = nil;
    FWRelease(_currentPopoverController);
    [super dealloc];
}


@end
