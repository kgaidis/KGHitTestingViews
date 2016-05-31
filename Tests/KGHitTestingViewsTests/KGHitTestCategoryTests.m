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

@interface CustomViewSubclass : UIView
@property (nonatomic) BOOL calledCustomPointInsideImplementation;
@end

@implementation CustomViewSubclass
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    self.calledCustomPointInsideImplementation = YES;
    return [super pointInside:point withEvent:event];
}
@end

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

- (void)testView_whenSettingMinimumWidthHeight_classNameShouldChange {
    UIView *view = [UIView new];
    Class initialClass = [view class];
    [view setMinimumHitTestWidth:10 height:10];
    Class newClass = [view class];
    XCTAssert(initialClass != newClass);
}

- (void)testView_whenSettingMinimumWidthHeight_hitAreaShouldAdjust {
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

- (void)testView_whenSettingMinimumWidthHeight_classNameShouldNotChangeMultipleTimes {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    Class initialClass = [view class];
    [view setMinimumHitTestWidth:10 height:10];
    Class newClass = [view class];
    XCTAssert(initialClass != newClass);
    [view setMinimumHitTestWidth:10 height:10];
    XCTAssert([NSStringFromClass(newClass) isEqualToString:NSStringFromClass([view class])]);
}

#pragma mark - KVO tests -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context { }

- (void)testView_whenRegisteringForKVOAfterSettingHitTestWidthHeight_thereShouldBeNoCrashes {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view setMinimumHitTestWidth:20 height:20];
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [view removeObserver:self forKeyPath:@"frame"];
}

- (void)testView_whenRegisteringForKVOBeforeSettingHitTestWidthHeight_thereShouldBeNoCrashes {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [view setMinimumHitTestWidth:20 height:20];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [view removeObserver:self forKeyPath:@"frame"];
}

- (void)testView_whenRegisteringForKVOAndUsingSameViewMultipleTimes_thereShouldBeNoCrashes {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [view setMinimumHitTestWidth:20 height:20];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view2 addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    XCTAssert([view2 pointInside:CGPointMake(9, 9) withEvent:nil]);
    XCTAssert(![view2 pointInside:CGPointMake(19, 19) withEvent:nil]);
    
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [view removeObserver:self forKeyPath:@"frame"];
    [view2 removeObserver:self forKeyPath:@"frame"];
}

- (void)testView_whenRegisteringForKVOBeforeSettingMinimumWidthHeight_hitAreaShouldAdjust {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    XCTAssertNotNil([view hitTest:CGPointMake(9, 9) withEvent:nil]);
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:10 height:10];
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [view removeObserver:self forKeyPath:@"frame"];
}

- (void)testView_whenRegisteringForKVOAfterSettingMinimumWidthHeight_hitAreaShouldAdjust {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    XCTAssertNotNil([view hitTest:CGPointMake(9, 9) withEvent:nil]);
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:10 height:10];
    XCTAssertNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [view setMinimumHitTestWidth:44 height:44];
    XCTAssertNotNil([view hitTest:CGPointMake(20, 20) withEvent:nil]);
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [view removeObserver:self forKeyPath:@"frame"];
}

- (void)testCustomViewSubclass_afterRegisteringKVOAndUsingHitTesting_customPointInsideImplementationShouldGetCalled {
    CustomViewSubclass *customView = [[CustomViewSubclass alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [customView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    [customView setMinimumHitTestWidth:20 height:20];
    [customView pointInside:CGPointZero withEvent:nil];
    XCTAssert(!customView.calledCustomPointInsideImplementation, @"The overriden 'pointInside:withEvent' should be called instead.");
    
    CustomViewSubclass *customView2 = [[CustomViewSubclass alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [customView2 addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    [customView2 pointInside:CGPointZero withEvent:nil];
    XCTAssert(customView2.calledCustomPointInsideImplementation);
    
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    [customView removeObserver:self forKeyPath:@"frame"];
    [customView2 removeObserver:self forKeyPath:@"frame"];
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
