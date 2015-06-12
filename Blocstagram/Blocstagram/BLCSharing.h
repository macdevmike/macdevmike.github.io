//
//  BLCSharing.h
//  Blocstagram
//
//  Created by Michael Henkelman on 6/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCSharing : NSObject

+ (UIActivityViewController *) shareData:(BLCMedia *)mediaItem;

@end
