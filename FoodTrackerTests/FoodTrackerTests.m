//
//  FoodTrackerTests.m
//  FoodTrackerTests
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Meal.h"

@interface FoodTrackerTests : XCTestCase

@end

@implementation FoodTrackerTests

// MARK: FoodTracker Tests

// Testing of meal initializer

-(void)testMealInitialization{
    //Success case
    Meal* potentialItem = [[Meal alloc] initWithName:@"Newest meal" Image:nil AndRating:5];
    XCTAssertNotNil(potentialItem);
    
    //Failure case
    
    Meal* noName = [[Meal alloc] initWithName:@"" Image:nil AndRating:0];
    XCTAssertNil(noName, "Empty name is invalid");
    
    Meal* badRating = [[Meal alloc] initWithName:@"Really bad rating" Image:nil AndRating:-1];
    XCTAssertNil(badRating, "Negative ratings are invalid, be positive");
    
}

@end
