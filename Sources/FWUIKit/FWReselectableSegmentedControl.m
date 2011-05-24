//
//  FWReselectableSegmentedControl.m
//  ToastAndTell
//
//  Created by Duane Fields on 5/22/11.
//  Copyright 2011 Demand Media, Inc. All rights reserved.
//

#import "FWReselectableSegmentedControl.h"


@implementation FWReselectableSegmentedControl

- (void)setSelectedSegmentIndex:(NSInteger)toValue {
    // Trigger UIControlEventValueChanged even when re-tapping the selected segment.
    if (toValue == self.selectedSegmentIndex) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    [super setSelectedSegmentIndex:toValue];        
}

@end
