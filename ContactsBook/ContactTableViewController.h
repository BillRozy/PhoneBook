//
//  MealTableViewController.h
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BorderRadius.h"
@protocol ReloadDelegate

- (void)updateRecentData: (NSArray *)arrayChangedParams;

@end

@interface ContactTableViewController : UITableViewController

// MARK: properties

@property (readwrite) NSMutableArray* contacts;
@property UITableViewCell* callingCell;
@property (weak, nonatomic) id<ReloadDelegate>delegate;

// MARK: navigation

-(IBAction)unwindToMealList:(UIStoryboardSegue*)sender;

//MARK: actions
- (IBAction)callContact:(UIButton *)sender;



// MARK: NSCoding

-(void)saveContacts;
-(NSArray*)loadContacts;
-(void)saveRecentsFromAlert:(NSArray*)recents;
-(NSArray*)loadRecents;


@end
