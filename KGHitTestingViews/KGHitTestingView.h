//
//  KGHitTestingView.h
//  KGHitTestingViews
//
//  Created by Krisjanis Gaidis on 5/2/15.
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