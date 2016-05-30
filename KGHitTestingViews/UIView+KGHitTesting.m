//
//  UIView+KGHitTesting.m
//  KGHitTestingViewsExample
//
//  Created by Krisjanis Gaidis on 5/28/16.
//  Copyright © 2016 Krisjanis Gaidis. All rights reserved.
//

#import "UIView+KGHitTesting.h"
#import "KGHitTestingHelper.h"
#import <objc/runtime.h>

static NSString * const kKGHitTestingClassPrefix = @"KGHitTesting_";

@implementation UIView (KGHitTesting)

- (void)setMinimumHitTestWidth:(CGFloat)width height:(CGFloat)height {
    [self kg_setMinimumHitTestWidth:width];
    [self kg_setMinimumHitTestHeight:height];
    
    Class currentClass = object_getClass(self);
    NSString *currentClassName = NSStringFromClass(currentClass);

    if (![currentClassName hasPrefix:kKGHitTestingClassPrefix]) {
        
        const char *newClassName = [[kKGHitTestingClassPrefix stringByAppendingString:currentClassName] UTF8String];
        Class existingNewClass = objc_getClass(newClassName);
        
        if (existingNewClass == nil) {
            Class newClass = objc_allocateClassPair(currentClass, [[kKGHitTestingClassPrefix stringByAppendingString:currentClassName] UTF8String], 0);
            IMP newImplementation = class_getMethodImplementation([self class], @selector(kg_pointInside:withEvent:));
            const char *types = [[NSString stringWithFormat:@"B@:%s@", @encode(CGPoint)] UTF8String];
            class_addMethod(newClass, @selector(pointInside:withEvent:), newImplementation, types);
            object_setClass(self, newClass);
            objc_registerClassPair(newClass);
        }
        else { // We already created a 'KGHitTesting_[self class]', so just use the created one
            object_setClass(self, existingNewClass);
        }
    }
}

- (BOOL)kg_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(KGHitTestingBounds(self.bounds, [self kg_minimumHitTestWidth], [self kg_minimumHitTestHeight]), point);
}

#pragma mark - Properties -

- (void)kg_setMinimumHitTestWidth:(CGFloat)minimumHitTestWidth {
    objc_setAssociatedObject(self, @selector(kg_minimumHitTestWidth), @(minimumHitTestWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)kg_minimumHitTestWidth {
    return [objc_getAssociatedObject(self, @selector(kg_minimumHitTestWidth)) floatValue];
}

- (void)kg_setMinimumHitTestHeight:(CGFloat)minimumHitTestHeight {
    objc_setAssociatedObject(self, @selector(kg_minimumHitTestHeight), @(minimumHitTestHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)kg_minimumHitTestHeight {
    return [objc_getAssociatedObject(self, @selector(kg_minimumHitTestHeight)) floatValue];
}

@end
