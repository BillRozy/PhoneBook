//
//  ViewController.m
//  FoodTracker
//
//  Created by fd on 31/03/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "ContactViewController.h"


@interface ContactViewController ()


@end

@implementation ContactViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self roundMyView:self.photoImageView borderRadius:50.0f borderWidth:3.0f color:[UIColor blackColor]];
    
    //handle textfield's user input through delegate callback
    self.nameTextField.delegate = self;
    self.phoneNumberTextField.delegate = self;
    
    if (self.contact != nil){
        self.navigationItem.title = self.contact.name;
        self.nameTextField.text = self.contact.name;
        self.photoImageView.image = self.contact.photo;
        CGSize zeroSize = CGSizeMake(0, 0);
        if (CGSizeEqualToSize(self.photoImageView.image.size,zeroSize)||self.photoImageView.image == nil) {
            self.photoImageView.image = [UIImage imageNamed:@"defaultPhoto"];
        }
        self.phoneNumberTextField.text = self.contact.phoneNumber;
    }
    
    [self checkValidContactName];
}

// MARK: UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.saveButton.enabled = false;
}

-(void)checkValidContactName{
    NSString* text = self.nameTextField.text;
    self.saveButton.enabled = !([text isEqual:@""] || [text isEqual:nil]);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkValidContactName];
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
-(UIImage*)testingOfImageExisting{
    if (self.photoImageView.image != nil){
        return self.photoImageView.image;}
    else{
        return [UIImage imageNamed:@"defaultPhoto"];}
}

// MARK: prepare data for contactTableController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([self.saveButton isEqual:sender]) {
        NSString* name = self.nameTextField.text;
        UIImage* photo = [self testingOfImageExisting];
        NSString* phoneNumber = self.phoneNumberTextField.text;
         self.contact = [[Contact alloc] initWithName:name Image:photo andPhoneNumber:phoneNumber];
        
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
