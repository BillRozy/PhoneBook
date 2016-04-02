//
//  RatingControl.h
//  FoodTracker
//
//  Created by fd on 01/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingControl : UIView

// MARK: Properties

@property NSUInteger rating;
@property (strong) NSMutableArray* buttons;

// MARK: Actions

-(void)layoutSubviews;
// -(void)setNeedsLayout;


@end
