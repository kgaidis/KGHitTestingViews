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

@property (nonatomic) IBInspectable CGFloat minimumHitTestHeight;
@property (nonatomic) IBInspectable CGFloat minimumHitTestWidth;

@end