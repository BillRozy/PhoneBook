//
//  MealTableViewCell.h
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"

@interface MealTableViewCell : UITableViewCell

// MARK: properties
@property (weak, nonatomic) IBOutlet RatingControl *ratingControl;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@end
