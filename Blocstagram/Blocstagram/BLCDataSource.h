//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Michael Henkelman on 5/26/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

@interface BLCDataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong) NSMutableArray *mediaItems;

- (void) deleteMediaItem:(BLCMedia *)item;

@end
