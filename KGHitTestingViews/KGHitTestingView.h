//
//  KGHitTestingView.h
//  KGHitTestingViews
//
//  Created by Krisjanis Gaidis on 5/2/15.
//  Copyright (c) 2015 Krisjanis Gaidis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGHitTesting.h"

@interface KGHitTestingView : UIView <KGHitTesting>

/**
 @desc  The minimum width that will be used when hit testing is
        performed.
 
        Specifying a larger value than the bounds width will
        increase the hit area of the view.
 
        Specifying a smaller value than the bounds width will
        cause no effect - the bounds width will be used for hit
        testing.
 
        The default value causes no effect.
 */
@property (nonatomic) IBInspectable CGFloat minimumHitTestWidth;

/**
 @desc  The minimum height that will be used when hit testing is
        performed.
 
        Specifying a larger value than the bounds height will
        increase the hit area of the view.
 
        Specifying a smaller value than the bounds height will
        cause no effect - the bounds height will be used for hit
        testing.
 
        The default value causes no effect.
 */
@property (nonatomic) IBInspectable CGFloat minimumHitTestHeight;

@end