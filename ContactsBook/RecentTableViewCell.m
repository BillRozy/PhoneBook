//
//  RecentTableViewCell.m
//  FoodTracker
//
//  Created by fd on 07/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "RecentTableViewCell.h"

@implementation RecentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self roundMyView:self.photoImageView borderRadius:32.0f borderWidth:2.0f color:[UIColor darkGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
