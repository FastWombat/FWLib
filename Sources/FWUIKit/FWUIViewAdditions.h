//
//  DMUIViewAdditions.h
//  DMShared
//
//  Created by Duane Fields on 4/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface UIView (FWUIViewAdditions)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic, readonly) CGPoint centerOfBounds;

@end
