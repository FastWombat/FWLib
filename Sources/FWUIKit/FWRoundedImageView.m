//
//  FWRoundedImageView.m
//  ToastAndTell
//
//  Created by Duane Fields on 3/8/11.
//

#import "FWRoundedImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FWRoundedImageView

- (void)setupLayer {
    [[self layer] setCornerRadius:8.0f];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setBorderWidth:2.0];
    [[self layer] setBorderColor:[[UIColor blackColor] CGColor]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLayer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
    }
    return self;
}

@end
