//
//  BLCMediaTableViewCell.h
//  Blocstagram
//
//  Created by Michael Henkelman on 5/28/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) BLCMedia *mediaItem;

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;


@end
