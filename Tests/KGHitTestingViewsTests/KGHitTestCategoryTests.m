//
//  KGHitTestCategoryTests.m
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 5/29/16.
//
//

#import <XCTest/XCTest.h>
#import "KGHitTestBaseTest.h"
#import "UIView+KGHitTesting.h"

@interface KGHitTestCategoryTests : KGHitTestBaseTest

@end

@implementation KGHitTestCategoryTests

- (void)setUp {
    [super setUp];
    self.hitTestObject = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
}

- (id<KGHitTesting>)increaseHitTestAreaForHitTestObject:(id<KGHitTesting>)hitTestObject {
    [((UIView *)hitTestObject) setMinimumHitTestWidth:kMinimumHitTestWidth height:kMinimumHitTestHeight];
    return hitTestObject;
}

#pragma mark - General tests -

- (void)testWhenSettingMinimumWidthHeight_classNameShouldChange {
    UIView *view = [UIView new];
    Class initialClass = [view class];
    [view setMinimumHitTestWidth:10 height:10];
    Class newClass = [view class];
    XCTAssert(initialClass != newClass);
}

- (void)testWhenSettingMinimumWidthHeightMultipleTimes_thereShouldBeNoIssues {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    XCTAssertNotNil([view hitTest:CGPointMake(9, 9) withEvent:nil]);
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:10 height:10];
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
}

#pragma mark - Top left corner -
- (void)testTopLeftCornerInBounds { [self _testTopLeftCornerInBounds]; }
- (void)testTopLeftCornerOutOfBounds { [self _testTopLeftCornerOutOfBounds]; }

#pragma mark - Top right corner -
- (void)testTopRightCornerInBounds { [self _testTopRightCornerInBounds]; }
- (void)testTopRightCornerOutOfBounds { [self _testTopRightCornerOutOfBounds]; }

#pragma mark - Bottom right corner -
- (void)testBottomRightCornerInBounds { [self _testBottomRightCornerInBounds]; }
- (void)testBottomRightCornerOutOfBounds { [self _testBottomRightCornerOutOfBounds]; }

#pragma mark - Bottom left corner -
- (void)testBottomLeftCornerInBounds { [self _testBottomLeftCornerInBounds]; }
- (void)testBottomLeftCornerOutOfBounds { [self _testBottomLeftCornerOutOfBounds]; }

@end
