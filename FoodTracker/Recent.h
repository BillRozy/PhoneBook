//
//  Recent.h
//  FoodTracker
//
//  Created by fd on 07/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface Recent : Contact

// MARK: properties

@property (strong) NSDate* date;

// MARK: archiving paths
+(NSURL*)ArchiveUrl;


// MARK: actions

-(instancetype)initWithName:(NSString *)name Image:(UIImage *)photo Date:(NSDate*)date andPhoneNumber:(NSString *)phoneNumber;

@end
