//
//  UIView+KGHitTesting.m
//  KGHitTestingViewsExample
//
//  Created by Krisjanis Gaidis on 5/28/16.
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
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
    
    if (isKVOSubclass(self)) {
        // We do NOT create a special class if the object was already 'isa-swizzled' by KVO.
        // We just reuse the special KVO class.
        [UIView kg_addHitTestImplementationToClass:currentClass];
    }
    else if (![NSStringFromClass(currentClass) hasPrefix:kKGHitTestingClassPrefix]) {
        const char *newClassName = [[kKGHitTestingClassPrefix stringByAppendingString:NSStringFromClass(currentClass)] UTF8String];
        Class newClass = objc_getClass(newClassName);
        if (newClass == nil) { // 'KGHitTesting_[self class]' does not exist yet, so lets create it!
            newClass = objc_allocateClassPair(currentClass, newClassName, 0);
            [UIView kg_addHitTestImplementationToClass:newClass];
            objc_registerClassPair(newClass);
        }
        object_setClass(self, newClass);
    }
}

+ (void)kg_addHitTestImplementationToClass:(Class)class {
    NSAssert([class isSubclassOfClass:[UIView class]], @"We should only be adding KGHitTesting implementation to a UIView subclass.");
    
    Method kg_pointInsideMethod = class_getInstanceMethod(class, @selector(kg_pointInside:withEvent:));
    IMP kg_pointInsideImplementation = class_getMethodImplementation(class, @selector(kg_pointInside:withEvent:));
    
    class_addMethod(class, @selector(pointInside:withEvent:), kg_pointInsideImplementation, method_getTypeEncoding(kg_pointInsideMethod));
}

- (BOOL)kg_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (objc_getAssociatedObject(self, @selector(kg_minimumHitTestWidth))) {
        return CGRectContainsPoint(KGHitTestingBounds(self.bounds, [self kg_minimumHitTestWidth], [self kg_minimumHitTestHeight]), point);
    }
    
    // If the Object was using KVO before using 'setMinimumHitTestWidth:height:', then
    // after using 'setMinimumHitTestWidth:height:', its class remains something like 'KVO_Object'.
    // This means that our custom 'pointInside:withEvent:' will get called for EVERY object that
    // has the class 'KVO_Object' - even if they never called 'setMinimumHitTestWidth:height:'
    // on that object. In those cases, the associated object ('kg_minimumHitTestWidth') will not be set.
    // When we notice that case, we make sure to call the ORIGINAL 'pointInside:withEvent:' so
    // there would be no surprises. 
    NSAssert(isKVOSubclass(self), @"Logic error. The only time a custom 'pointInside:withEvent:' should get to this point is if the object is using KVO.");
    Class actualClass = [self class];
    IMP originalPointInside = class_getMethodImplementation(actualClass, @selector(pointInside:withEvent:));
    return ((BOOL (*)(id, SEL, CGPoint, UIEvent *))originalPointInside)(self, _cmd, point, event);
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

#pragma mark - Runtime helpers -
// A lot of inspiration from:
// https://github.com/mikeash/MAZeroingWeakRef

static BOOL isKVOSubclass(id object) {
    // [self class] gets overriden by the KVO class to return the super class
    // However, 'class_getSuperclass' uncovers the actual class (which is 'NSKVONotifying_[self class]')
    return [object class] == class_getSuperclass(object_getClass(object));
}

@end
