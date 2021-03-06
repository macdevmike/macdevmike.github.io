//
//  BLCMediaFullScreenAnimator.h
//  Blocstagram
//
//  Created by Michael Henkelman on 6/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BLCMediaFullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, weak) UIImageView *cellImageView;

@end