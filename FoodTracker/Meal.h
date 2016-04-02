//
//  Meal.h
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Meal : NSObject

// MARK: properties

@property (strong) NSString* name;
@property (weak) UIImage* photo;
@property NSInteger rating;

// MARK: actions

-(instancetype)initWithName:(NSString*)name Image:(UIImage*)photo AndRating:(NSInteger)rating;

@end