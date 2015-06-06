//
//  BLCComment.h
//  Blocstagram
//
//  Created by Michael Henkelman on 5/26/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCUser;

 @interface BLCComment : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *from;
@property (nonatomic, strong) NSString *text;

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;


@end
