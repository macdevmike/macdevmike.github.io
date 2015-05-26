//
//  BLCUser.h
//  Blocstagram
//
//  Created by Michael Henkelman on 5/26/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLCUser : NSObject
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

@end
