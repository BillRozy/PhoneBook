//
//  RecentsTableViewController.h
//  FoodTracker
//
//  Created by fd on 07/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentTableViewCell.h"





@interface RecentsTableViewController : UITableViewController

//MARK: properties

@property (readwrite) NSMutableArray* recents;



//MARK: NSCoding

-(void)saveRecents;
-(NSArray*)loadRecents;


//MARK: test




@end
