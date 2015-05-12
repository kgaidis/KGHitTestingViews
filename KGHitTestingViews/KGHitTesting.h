//
//  KGHitTesting.h
//  KGHitTestingViewsTests
//
//  Created by Krisjanis Gaidis on 5/10/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KGHitTesting <NSObject>

@required

@property (nonatomic) CGFloat minimumHitTestHeight;
@property (nonatomic) CGFloat minimumHitTestWidth;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@end