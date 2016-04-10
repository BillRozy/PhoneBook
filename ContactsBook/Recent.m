//
//  Recent.m
//  FoodTracker
//
//  Created by fd on 07/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "Recent.h"

@implementation Recent

// MARK: init

-(instancetype)initWithName:(NSString *)name Image:(UIImage *)photo Date:(NSDate *)date andPhoneNumber:(NSString *)phoneNumber{
    
    self.name = name;
    self.photo = photo;
    self.phoneNumber = phoneNumber;
    self.date = date;
    if ([name isEqualToString:@""] || name == nil || phoneNumber == nil || [phoneNumber isEqual:@""] || date == nil ) {
        return nil;
    }
    return self;
}

// MARK: Archiving Paths



+(NSURL*)ArchiveUrl{
    return [[Recent DocumentsDirectory] URLByAppendingPathComponent:@"recents"];
}



#pragma mark NSCoding

#define nameKey       @"name"
#define photoKey      @"photo"
#define phoneNumberKey @"phoneNumber"
#define dateKey       @"date"

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.name forKey:nameKey];
    [aCoder encodeObject:self.photo forKey:photoKey];
    [aCoder encodeObject:self.phoneNumber forKey:phoneNumberKey];
    [aCoder encodeObject:self.date forKey:dateKey];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name = [aDecoder decodeObjectForKey:nameKey];
    UIImage* photo = [aDecoder decodeObjectForKey:photoKey];
    NSString *phoneNumber = [aDecoder decodeObjectForKey:phoneNumberKey];
    NSDate *date = [aDecoder decodeObjectForKey:dateKey];
    NSLog(@"In photoo: %@", photo);
    return [self initWithName:name Image:photo Date:date andPhoneNumber:phoneNumber];
}


@end
