//
//  ViewController.h
//  FoodTracker
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"
#import "Meal.h"

@interface MealViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// MARK: properties

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *selectImageGesture;
@property (weak, nonatomic) IBOutlet RatingControl *ratingControl;
@property (strong) Meal* meal;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


// MARK: UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(void)textFieldDidEndEditing:(UITextField *)textField;
-(void)checkValidMealName;

// MARK: navigation
- (IBAction)cancel:(UIBarButtonItem *)sender;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

// MARK: actions

- (IBAction)selectImageFromPhotoLibrary:(UITapGestureRecognizer *)sender;

// MARK: UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@end

