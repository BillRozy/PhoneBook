//
//  ViewController.h
//  FoodTracker
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "UIViewController+BorderRadius.h"




@interface ContactViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// MARK: properties

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *selectImageGesture;
@property (strong) Contact* contact;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


// MARK: UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(void)textFieldDidEndEditing:(UITextField *)textField;

// MARK: navigation
- (IBAction)cancel:(UIBarButtonItem *)sender;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

// MARK: actions

- (IBAction)selectImageFromPhotoLibrary:(UITapGestureRecognizer *)sender;

// MARK: UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@end

