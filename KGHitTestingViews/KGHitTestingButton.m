//
//  KGHitTestingButton.m
//  KGHitTestingViews
//
//  Created by Krisjanis Gaidis on 5/2/15.
//  Copyright (c) 2015 Krisjanis Gaidis. All rights reserved.
//

#import "KGHitTestingButton.h"
#import "KGHitTestingHelper.h"

@implementation KGHitTestingButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(KGHitTestingBounds(self.bounds, self.minimumHitTestWidth, self.minimumHitTestHeight), point);
}

@end
