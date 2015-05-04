//
//  WhiskeyViewController.h
//  Alcolator
//
//  Created by Michael Henkelman on 5/4/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhiskeyViewController : UIViewController
@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

- (void)buttonPressed:(UIButton *)sender;

@end
