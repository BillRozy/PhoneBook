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
    Meal* potentialItem = [[Meal alloc] initWithName:@"Newest meal" Image:nil andPhoneNumber:@"123213131" ];
    XCTAssertNotNil(potentialItem);
    
    //Failure case
    
    Meal* noName = [[Meal alloc] initWithName:@"" Image:nil andPhoneNumber:@"1231231231"];
    XCTAssertNil(noName, "Empty name is invalid");
    
    Meal* badRating = [[Meal alloc] initWithName:@"Really bad rating" Image:nil andPhoneNumber:@"213123131"];
    XCTAssertNil(badRating, "Negative ratings are invalid, be positive");
    
}

@end
