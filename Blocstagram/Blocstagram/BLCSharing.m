//
//  BLCSharing.m
//  Blocstagram
//
//  Created by Michael Henkelman on 6/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import "BLCSharing.h"
#import "BLCMedia.h"

@implementation BLCSharing

+ (UIActivityViewController *) shareData:(BLCMedia *)mediaItem {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (mediaItem.caption.length > 0) {
        [itemsToShare addObject:mediaItem.caption];
    }
    
    if (mediaItem.image) {
        [itemsToShare addObject:mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        return activityVC;
    }
    return nil;
}
@end
