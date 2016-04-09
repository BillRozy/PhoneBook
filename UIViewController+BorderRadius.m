//
//  UIViewController+BorderRadius.m
//  FoodTracker
//
//  Created by fd on 09/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "UIViewController+BorderRadius.h"

@implementation UIViewController (BorderRadius)

- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color
{
    CALayer *layer = [view layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    layer.borderWidth = border;
    layer.borderColor = color.CGColor;
}

@end


@implementation UITableViewCell (BorderRadius)

- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color
{
    CALayer *layer = [view layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    layer.borderWidth = border;
    layer.borderColor = color.CGColor;
}

@end

