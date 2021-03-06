//
//  FoodTrackerTests.m
//  FoodTrackerTests
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Contact.h"

@interface FoodTrackerTests : XCTestCase

@end

@implementation FoodTrackerTests

// MARK: FoodTracker Tests

// Testing of meal initializer

-(void)testMealInitialization{
    //Success case
    Contact* potentialItem = [[Contact alloc] initWithName:@"Newest contact" Image:nil andPhoneNumber:@"123213131" ];
    XCTAssertNotNil(potentialItem);
    
    //Failure case
    
    Contact* noName = [[Contact alloc] initWithName:@"" Image:nil andPhoneNumber:@"1231231231"];
    XCTAssertNil(noName, "Empty name is invalid");
    

    
}

@end
