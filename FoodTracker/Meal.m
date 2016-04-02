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

-(instancetype)initWithName:(NSString*)name Image:(UIImage*)photo AndRating:(NSInteger)rating{
    
    self.name = name;
    self.photo = photo;
    self.rating = rating;
    if ([name isEqualToString:@""] || rating < 0 || name == nil) {
        return nil;
    }
    return self;
}


@end