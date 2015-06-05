//
//  BLCComment.m
//  Blocstagram
//
//  Created by Michael Henkelman on 5/26/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import "BLCComment.h"
#import "BLCUser.h"

@implementation BLCComment

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = commentDictionary[@"id"];
        self.text = commentDictionary[@"text"];
        self.from = [[BLCUser alloc] initWithDictionary:commentDictionary[@"from"]];
    }
    
    return self;
}

@end
