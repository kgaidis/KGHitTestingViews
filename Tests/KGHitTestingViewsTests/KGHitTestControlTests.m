//
//  KGHitTestControlTests.m
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 1/9/16.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KGHitTestingControl.h"
#import "KGHitTestBaseTest.h"

@interface KGHitTestControlTests : KGHitTestBaseTest

@end

@implementation KGHitTestControlTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.hitTestObject = [[KGHitTestingControl alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
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
