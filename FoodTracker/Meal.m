//
//  Meal.m
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//


#import "Meal.h"



@implementation Meal

// MARK: init

-(instancetype)initWithName:(NSString*)name Image:(UIImage*)photo andPhoneNumber:(NSString *)phoneNumber {
    
    self.name = name;
    self.photo = photo;
    self.phoneNumber = phoneNumber;
    if ([name isEqualToString:@""] || name == nil || phoneNumber == nil || [phoneNumber isEqual:@""] ) {
        return nil;
    }
    return self;
}

// MARK: Archiving Paths

+(NSURL*)DocumentsDirectory{
    return [[NSFileManager new] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

+(NSURL*)ArchiveUrl{
    return [[Meal DocumentsDirectory] URLByAppendingPathComponent:@"meals"];
}



#pragma mark NSCoding

#define nameKey       @"name"
#define photoKey      @"photo"
#define phoneNumberKey @"phoneNumber"

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.name forKey:nameKey];
    [aCoder encodeObject:self.photo forKey:photoKey];
    [aCoder encodeObject:self.phoneNumber forKey:phoneNumberKey];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name = [aDecoder decodeObjectForKey:nameKey];
    UIImage* photo = [aDecoder decodeObjectForKey:photoKey];
    NSString *phoneNumber = [aDecoder decodeObjectForKey:phoneNumberKey];
    NSLog(@"In photoo: %@", photo);
    return [self initWithName:name Image:photo andPhoneNumber:phoneNumber];
}




@end