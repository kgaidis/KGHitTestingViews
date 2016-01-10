//
//  KGHitTestingControl.m
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 1/9/16.
//
//

#import "KGHitTestingControl.h"
#import "KGHitTestingHelper.h"

@implementation KGHitTestingControl

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(KGHitTestingBounds(self.bounds, self.minimumHitTestWidth, self.minimumHitTestHeight), point);
}

@end
