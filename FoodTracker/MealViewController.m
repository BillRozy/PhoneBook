//
//  ViewController.m
//  FoodTracker
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "MealViewController.h"

@interface MealViewController ()





@end

@implementation MealViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //handle textfield's user input through delegate callback
    self.nameTextField.delegate = self;
    [self checkValidMealName];
}

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
// MARK: UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.photoImageView.image = selectedImage;
    [picker dismissViewControllerAnimated:true completion:nil];
    
}

// MARK: navigation

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([self.saveButton isEqual:sender]) {
        NSString* name = self.nameTextField.text;
        UIImage* photo = self.photoImageView.image;
        NSInteger rating = self.ratingControl.rating;
        self.meal = [[Meal alloc] initWithName:name Image:photo AndRating:rating];
        
    }
}

// MARK: actions
- (IBAction)selectImageFromPhotoLibrary:(UITapGestureRecognizer *)sender {
    
    [self.nameTextField resignFirstResponder];
    UIImagePickerController* imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSLog(@"imagePicker: %@", imagePickerController);
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:true completion:nil];
    
    
}


@end
