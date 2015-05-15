//
//  ViewController.h
//  BlocBrowser
//
//  Created by Michael Henkelman on 5/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 Replaces the web view with a fresh one, erasing all history. This also updates the URL field and tool bar buttons appropriately.
 This must be implemented in the MVC.m file
 */
- (void) resetWebView;

@end

