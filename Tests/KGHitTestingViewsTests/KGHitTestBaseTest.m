//
//  KGHitTestBaseTest.m
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 5/10/15.
//
//

#import "KGHitTestBaseTest.h"

@implementation KGHitTestBaseTest

- (void)setUp {
    [super setUp];
    // Override setup in each subclass.
}

- (void)tearDown {
    self.hitTestObject = nil;
    [super tearDown];
}

#pragma mark - Helpers -

- (id<KGHitTesting>)increaseHitTestAreaForHitTestObject:(id<KGHitTesting>)hitTestObject {
    hitTestObject.minimumHitTestHeight = kMinimumHitTestHeight;
    hitTestObject.minimumHitTestWidth = kMinimumHitTestWidth;
    return hitTestObject;
}

#pragma mark - Top left corner -

- (void)_testTopLeftCornerInBounds {
    XCTAssert([self.hitTestObject pointInside:CGPointMake(0, 0) withEvent:nil]);
    XCTAssert([[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(-kWidthOffset, -kHeightOffset) withEvent:nil]);
}

- (void)_testTopLeftCornerOutOfBounds {
    XCTAssert(![self.hitTestObject pointInside:CGPointMake(-0.1, -0.1) withEvent:nil]);
    XCTAssert(![[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(-kWidthOffset-0.1, -kHeightOffset-0.1) withEvent:nil]);
}

#pragma mark - Top right corner -

- (void)_testTopRightCornerInBounds {
    XCTAssert([self.hitTestObject pointInside:CGPointMake(kWidth-0.1, 0.0) withEvent:nil]);
    XCTAssert([[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(kWidth+kWidthOffset-0.1, kHeightOffset) withEvent:nil]);
}

- (void)_testTopRightCornerOutOfBounds {
    XCTAssert(![self.hitTestObject pointInside:CGPointMake(kWidth+0.1, 0.1) withEvent:nil]);
    XCTAssert(![[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(kWidth+kWidthOffset+0.1, kHeightOffset+0.1) withEvent:nil]);
}

#pragma mark - Bottom right corner -

- (void)_testBottomRightCornerInBounds {
    XCTAssert([self.hitTestObject pointInside:CGPointMake(kWidth-0.1, kHeight-0.1) withEvent:nil]);
    XCTAssert([[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(kWidth+kWidthOffset-0.1, kHeight+kHeightOffset-0.1) withEvent:nil]);
}

- (void)_testBottomRightCornerOutOfBounds {
    XCTAssert(![self.hitTestObject pointInside:CGPointMake(kWidth+0.1, kHeight+0.1) withEvent:nil]);
    XCTAssert(![[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(kWidth+kWidthOffset+0.1, kHeight+kHeightOffset+0.1) withEvent:nil]);
}

#pragma mark - Bottom left corner -

- (void)_testBottomLeftCornerInBounds {
    XCTAssert([self.hitTestObject pointInside:CGPointMake(0, kHeight-0.1) withEvent:nil]);
    XCTAssert([[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(-kWidthOffset, kHeight+kHeightOffset-0.1) withEvent:nil]);
}

- (void)_testBottomLeftCornerOutOfBounds {
    XCTAssert(![self.hitTestObject pointInside:CGPointMake(0, kHeight+0.1) withEvent:nil]);
    XCTAssert(![[self increaseHitTestAreaForHitTestObject:self.hitTestObject] pointInside:CGPointMake(-kWidthOffset-0.1, kHeight+kHeightOffset+0.1) withEvent:nil]);
}

@end
