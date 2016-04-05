//
//  Meal.h
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Meal : NSObject<NSCoding>

// MARK: properties

@property (strong) NSString* name;
@property (strong) UIImage* photo;
@property (strong) NSString* phoneNumber;


// MARK: archiving paths
+(NSURL*)DocumentsDirectory;
+(NSURL*)ArchiveUrl;

// MARK: actions

-(instancetype)initWithName:(NSString*)name Image:(UIImage*)photo andPhoneNumber:(NSString*)phoneNumber;





@end