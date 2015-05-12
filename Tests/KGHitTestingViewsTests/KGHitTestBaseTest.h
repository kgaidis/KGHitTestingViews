//
//  KGHitTestBaseTest.h
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 5/10/15.
//
//

#import <XCTest/XCTest.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "KGHitTesting.h"

static const CGFloat kWidth = 10.0;
static const CGFloat kHeight = 10.0;
static const CGFloat kMinimumHitTestWidth = 20.0;
static const CGFloat kMinimumHitTestHeight = 20.0;

static const CGFloat kWidthOffset = (kMinimumHitTestWidth - kWidth) / 2;
static const CGFloat kHeightOffset = (kMinimumHitTestHeight - kHeight) / 2;

@interface KGHitTestBaseTest : XCTestCase

@property (strong, nonatomic) id<KGHitTesting> hitTestObject;

#pragma mark - Top left corner -
- (void)_testTopLeftCornerInBounds;
- (void)_testTopLeftCornerOutOfBounds;

#pragma mark - Top right corner -
- (void)_testTopRightCornerInBounds;
- (void)_testTopRightCornerOutOfBounds;

#pragma mark - Bottom right corner -
- (void)_testBottomRightCornerInBounds;
- (void)_testBottomRightCornerOutOfBounds;

#pragma mark - Bottom left corner -
- (void)_testBottomLeftCornerInBounds;
- (void)_testBottomLeftCornerOutOfBounds;

@end
