//
//  FWPopupManager.h
//  CalorieTracker
//
//  Created by Duane Fields on 9/1/11.
//  Copyright 2011 Fast Wombat, LLC All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWPopoverManager : NSObject<UIPopoverControllerDelegate> {
    UIPopoverController* _currentPopoverController;
}

+ (FWPopoverManager*)defaultManager;

+ (UIPopoverController*)popoverControllerWithContentViewController:(UIViewController*)viewController;


- (UIPopoverController*)popoverControllerWithContentViewController:(UIViewController*)viewController;
@property (nonatomic, readonly) UIPopoverController* currentPopoverController;

@end
