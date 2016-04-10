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
    self.saveButton.enabled = false;
    
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
    

    [self checkValidContactInfo];
}

// MARK: UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.saveButton.enabled = false;
     [self checkValidContactInfo];
}


-(void)checkValidContactInfo{
    NSString* name = self.nameTextField.text;
    NSString* number = self.phoneNumberTextField.text;
    self.saveButton.enabled = !([name isEqual:@""] || [name isEqual:nil] || [number isEqual:nil] || [number isEqual:@""]);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self checkValidContactInfo];
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
    NSString* presentedClass = [NSString stringWithFormat:@"%@",[presented class]];
    NSLog(@"%@", presentedClass);
    if ([presentedClass isEqualToString:@"UITabBarController"]){
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
