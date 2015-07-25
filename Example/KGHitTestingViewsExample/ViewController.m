//
//  ViewController.m
//  KGHitTestingViewsExample
//
//  Created by Krisjanis Gaidis on 5/2/15.
//  Copyright (c) 2015 Krisjanis Gaidis. All rights reserved.
//

#import "ViewController.h"
#import "KGHitTestingButton.h"
#import "KGHitTestingHelper.h"

static NSString *const kWidthKeyPath = @"button.minimumHitTestWidth";
static NSString *const kHeightKeyPath = @"button.minimumHitTestHeight";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet KGHitTestingButton *button;
@property (weak, nonatomic) IBOutlet UIView *hitTestAreaView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hitTestAreaViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hitTestAreaViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UISlider *widthSlider;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UISlider *heightSlider;

@property (weak, nonatomic) IBOutlet UILabel *hitTestingBoundsLabel;

@end

@implementation ViewController

#pragma mark - Lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKVO];
    [self setupSliders];
    
    // Important Note:
    // The 'minimumHitTestWidth' and 'minimumHitTestHeight' are first set as the
    // IBInspectable "User Defined Runtime Attributes" in "Main.storyboard" for
    // the UIButton.
    
    [self updateOutlets];
}

- (void)dealloc {
    [self unregisterForKVO];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Helpers -

- (void)setupSliders {
    // Autolayout doesn't seem to like height/width values of 0.
    self.widthSlider.minimumValue = 1.0;
    self.heightSlider.minimumValue = 1.0;
    self.widthSlider.maximumValue = 250.0;
    self.heightSlider.maximumValue = 250.0;
}

- (void)updateOutlets {
    
    // Update width
    self.hitTestAreaViewWidthConstraint.constant = self.button.minimumHitTestWidth;
    self.widthLabel.text = [NSString stringWithFormat:@"minimumHitTestWidth: %@", @(self.button.minimumHitTestWidth)];
    
    // Update height
    self.hitTestAreaViewHeightConstraint.constant = self.button.minimumHitTestHeight;
    self.heightLabel.text = [NSString stringWithFormat:@"minimumHitTestHeight: %@", @(self.button.minimumHitTestHeight)];
    
    // Update bounds
    self.hitTestingBoundsLabel.text = [NSString stringWithFormat:@"HitTestingBounds:\n%@", NSStringFromCGRect(KGHitTestingBounds(self.button.bounds, self.button.minimumHitTestWidth, self.button.minimumHitTestHeight))];
    
    // Update sliders
    self.widthSlider.value = self.button.minimumHitTestWidth;
    self.heightSlider.value = self.button.minimumHitTestHeight;
}

#pragma mark - KVO Observing -

- (void)registerForKVO {
    [self addObserver:self forKeyPath:kWidthKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kHeightKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unregisterForKVO {
    [self removeObserver:self forKeyPath:kWidthKeyPath context:nil];
    [self removeObserver:self forKeyPath:kHeightKeyPath context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self updateOutlets];
}

#pragma mark - Slider actions -

- (IBAction)didChangeValueOfWidthSlider:(UISlider *)widthSlider {
    [widthSlider setValue:(NSUInteger)(widthSlider.value + 0.5) animated:NO];
    self.button.minimumHitTestWidth = widthSlider.value;
}

- (IBAction)didChangeValueOfHeightSlider:(UISlider *)heightSlider {
    [heightSlider setValue:(NSUInteger)(heightSlider.value + 0.5) animated:NO];
    self.button.minimumHitTestHeight = heightSlider.value;
}

@end
