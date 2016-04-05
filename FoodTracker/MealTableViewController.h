//
//  MealTableViewController.h
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealTableViewController : UITableViewController

// MARK: properties

@property (readwrite) NSMutableArray* meals;
@property UITableViewCell* callingCell;

// MARK: navigation

-(IBAction)unwindToMealList:(UIStoryboardSegue*)sender;

//MARK: actions
- (IBAction)callContact:(UIButton *)sender;



// MARK: NSCoding

-(void)saveMeals;
-(NSArray*)loadMeals;


@end
