//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Michael Henkelman on 6/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;

@end
