//
//  ViewController.h
//  Alcolator
//
//  Created by Michael Henkelman on 5/3/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;


- (void)buttonPressed:(UIButton *)sender;

@end

