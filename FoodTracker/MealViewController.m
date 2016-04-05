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
    self.phoneNumberTextField.delegate = self;
    
    if (self.meal != nil){
        self.navigationItem.title = self.meal.name;
        self.nameTextField.text = self.meal.name;
        self.photoImageView.image = self.meal.photo;
        self.phoneNumberTextField.text = self.meal.phoneNumber;
    }
    
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
    self.navigationItem.title = self.nameTextField.text;
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
    id presented = self.presentingViewController;
    id presentedClass = [presented class];
    if ([presentedClass isEqualToString:@"UINavigationController"]){
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:true];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([self.saveButton isEqual:sender]) {
        NSString* name = self.nameTextField.text;
        UIImage* photo = self.photoImageView.image;
        NSString* phoneNumber = self.phoneNumberTextField.text;
         self.meal = [[Meal alloc] initWithName:name Image:photo andPhoneNumber:phoneNumber];
        
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
