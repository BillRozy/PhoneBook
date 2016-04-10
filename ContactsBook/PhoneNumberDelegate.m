//
//  PhoneNumberDelegate.m
//  FoodTracker
//
//  Created by fd on 05/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneNumberDelegate.h"

@implementation PhoneNumberDelegate


// MARK: UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.saveButton.enabled = false;
}

-(void)checkValidMealName{
    NSString* text = self.nameTextField.text;
    self.saveButton.enabled = !([text isEqual:@""] || [text isEqual:nil]);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkValidMealName];
    self.navigationItem.title = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}


@end