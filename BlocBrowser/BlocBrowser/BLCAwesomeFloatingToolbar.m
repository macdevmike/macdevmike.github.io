//
//  BLCAwesomeFloatingToolbar.m
//  BlocBrowser
//
//  Created by Michael Henkelman on 5/18/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import "BLCAwesomeFloatingToolbar.h"

@interface BLCAwesomeFloatingToolbar ()

@property (nonatomic, strong) NSArray *currentTitles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, weak) UIButton *currentLabel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation BLCAwesomeFloatingToolbar

- (instancetype) initWithFourTitles:(NSArray *)titles {
    
    self = [super init];
    
    if (self) {
        
        self.currentTitles = titles;
        self.colors = @[[UIColor colorWithRed: 199/255.0 green:158/255.0 blue:203/255.0 alpha:1],
                        [UIColor colorWithRed: 255/255.0 green:105/255.0 blue:97/255.0 alpha:1],
                        [UIColor colorWithRed: 222/255.0 green:165/255.0 blue:164/255.0 alpha:1],
                        [UIColor colorWithRed: 255/255.0 green:179/255.0 blue:71/255.0 alpha:1]];
        
        NSMutableArray *labelsArray = [[NSMutableArray alloc] init];
        
        for (NSString *currentTitle in self.currentTitles) {
            UIButton *label = [[UIButton alloc] init];
            label.userInteractionEnabled = NO;
            label.alpha = 0.25;
            
            NSUInteger currentTitleIndex = [self.currentTitles indexOfObject:currentTitle];
            NSString *titleForThisLabel = [self.currentTitles objectAtIndex:currentTitleIndex];
            UIColor *colorForThisLabel = [self.colors objectAtIndex:currentTitleIndex];
            
            label.titleLabel.font = [UIFont systemFontOfSize:10];
            [label setTitle:titleForThisLabel forState:UIControlStateNormal];
            label.backgroundColor = colorForThisLabel;
            
            [labelsArray addObject:label];
            
            [label addTarget:self action:@selector(tapFired:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        self.labels = labelsArray;
        
        for (UIButton *thisLabel in self.labels) {
            [self addSubview:thisLabel];
        }
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFired:)];
        [self addGestureRecognizer:self.panGesture];
        self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchFired:)];
        [self addGestureRecognizer:self.pinchGesture];
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
    }
    
    return self;
}

- (void) tapFired:(UIButton *)recognizer {
            if ([self.delegate respondsToSelector:@selector(floatingToolbar:didSelectButtonWithTitle:)]) {
                [self.delegate floatingToolbar:self didSelectButtonWithTitle:recognizer.titleLabel.text];
            }
}

- (void) panFired:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        
        NSLog(@"New Translation: %@", NSStringFromCGPoint(translation));
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didTrytToPanWithOffset:)]) {
            [self.delegate floatingToolbar:self didTrytToPanWithOffset:translation];
        }
        
        [recognizer setTranslation:CGPointZero inView:self];
    }
}

- (void) pinchFired:(UIPinchGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat scale = [recognizer scale];
        
        NSLog(@"pinched: %f", scale);
        
        if ([self.delegate respondsToSelector:@selector(floatingToolbar:didPinchWithScale:)]) {
            [self.delegate floatingToolbar:self didPinchWithScale:scale];
        }
    }
}

- (void) longPressFired:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        self.colors = @[self.colors[1],self.colors[2],self.colors[3], self.colors[4]];
        for (NSInteger i=0; i<self.colors.count; i++)    {
            UIButton *label = self.labels[i];
            UIColor *color = self.colors[i];
            label.backgroundColor = color;
        }
    }
}

- (void) layoutSubviews {
    
    for (UIButton *thisLabel in self.labels) {
        NSUInteger currentLabelIndex = [self.labels indexOfObject:thisLabel];
        
        CGFloat labelHeight = CGRectGetHeight(self.bounds) /2;
        CGFloat labelWidth = CGRectGetWidth(self.bounds) /2;
        CGFloat labelX = 0;
        CGFloat labelY = 0;
        
        if (currentLabelIndex < 2) {
            labelY = 0;
        } else {
            labelY = CGRectGetHeight(self.bounds) /2;
        }
        
        if (currentLabelIndex % 2 ==0) {
            labelX = 0;
        } else {
            labelX = CGRectGetWidth(self.bounds) /2;
        }
        
        thisLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
    }
    
}


#pragma mark = Touch Handling




#pragma mark - Button Enabling

- (void) setEnabled:(BOOL)enabled forButtonWithTitle:(NSString *)title {
    NSUInteger index = [self.currentTitles indexOfObject:title];
    
    if (index != NSNotFound) {
        UIButton *label = [self.labels objectAtIndex:index];
        label.userInteractionEnabled = enabled;
        label.alpha = enabled ? 1.0 : 0.25;
    }
}
@end
