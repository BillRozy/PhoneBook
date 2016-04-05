//
//  RatingControl.m
//  FoodTracker
//
//  Created by fd on 01/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "RatingControl.h"

@implementation RatingControl

// MARK: Properties

const int spacing = 5;
const int starCount = 5;

//-(void)didChangeValueForKey:(NSString *)@"rating"
//{
//}




// MARK: Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       self.buttons = [[NSMutableArray alloc] initWithCapacity:starCount];
        self.rating = 1;
        UIImage* filledStarImage = [UIImage imageNamed:@"fullStar"];
        UIImage* emptyStarImage = [UIImage imageNamed:@"emptyStar"];
        
        
        for (int i=0; i<starCount;i++)
        {
        UIButton* button = [UIButton new];
            [button setImage:emptyStarImage forState:UIControlStateNormal];
            [button setImage:filledStarImage forState:UIControlStateSelected];
            [button setImage:filledStarImage forState:UIControlStateSelected &&UIControlStateHighlighted];
            button.adjustsImageWhenHighlighted = false;
            
            
            [button addTarget:self action:@selector(ratingButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [self.buttons addObject:button];
        [self addSubview:button];
        }
         
    }
    return self;

}

-(CGSize)intrinsicContentSize
{
    int buttonSize = self.frame.size.height;
    int width = (buttonSize * starCount) + (spacing * (starCount-1));
    CGSize size = {.width=width, .height = buttonSize};
    return size;
}

-(void)layoutSubviews{
    int buttonSize = self.frame.size.height;
    CGSize size = {.width=buttonSize, .height = buttonSize};
    CGPoint point = {.x=0, .y = 0};
    CGRect buttonFrame = {.origin = point, .size = size};
    int i = 0;
    for (UIButton* button in self.buttons) {
        buttonFrame.origin.x = (i * (buttonSize+spacing));
        button.frame = buttonFrame;
        i++;
    }
    [self updateButtonSelectionStates];
}

// MARK: Button Action

-(void) ratingButtonTapped:(UIButton*)button
{
    self.rating = [self.buttons indexOfObject:button] + 1;
    [self updateButtonSelectionStates];
    
}

-(void)updateButtonSelectionStates
{ int index = 0;
    for (UIButton* button in self.buttons) {
        button.selected = index<self.rating;
        index++;
    }
}

@end
