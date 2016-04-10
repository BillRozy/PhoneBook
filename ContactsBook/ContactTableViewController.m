//
//  MealTableViewController.m
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "ContactTableViewController.h"
#import "Contact.h"
#import "ContactTableViewCell.h"
#import "ContactViewController.h"
#import "Recent.h"


@interface ContactTableViewController ()

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
   NSArray* savedContacts = [self loadContacts];
    NSMutableArray* resulter = [NSMutableArray arrayWithArray:savedContacts];
    if(![savedContacts isEqualToArray:@[]])
    {
        
        self.contacts = resulter;
   }
    else
    {
    
    [self loadSampleContacts];
    }
    NSLog(@"WHAT INSIDE? %@ %@ %@",[self.contacts.firstObject name],[self.contacts.firstObject photo], [self.contacts.firstObject phoneNumber]);
  }

-(void)loadSampleContacts{
    Contact* contact1 = [[Contact alloc] initWithName:@"Jones Dave" Image:nil andPhoneNumber:@"89087517220"];
    
    Contact* contact2 = [[Contact alloc] initWithName:@"Taylor Margaret" Image:nil andPhoneNumber:@"89601825549"];
    
    Contact* contact3 = [[Contact alloc] initWithName:@"Kozima Takeshi" Image:nil andPhoneNumber:@"89307653651"];
    
    self.contacts = [[NSMutableArray alloc] initWithArray:@[contact1, contact2, contact3]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier = @"MealTableViewCell";

    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Contact* contact = [self.contacts objectAtIndex:indexPath.row];
    cell.nameLabel.text = contact.name;
    cell.photoImageView.image = contact.photo;
    CGSize zeroSize = CGSizeMake(0, 0);
      if (CGSizeEqualToSize(cell.photoImageView.image.size,zeroSize)||cell.photoImageView.image == nil) {
        cell.photoImageView.image = [UIImage imageNamed:@"defaultPhoto"];
    }
    cell.phoneNumberLabel.text = contact.phoneNumber;
    return cell;
}

// MARK: navigation

-(void)unwindToMealList:(UIStoryboardSegue *)sender{
    ContactViewController* sourceViewController = sender.sourceViewController;
    Contact* contact = sourceViewController.contact;
    if (sourceViewController != nil && contact != nil)
    { NSIndexPath* selectedIndexPath = self.tableView.indexPathForSelectedRow;
             if (selectedIndexPath) {
                 [self.contacts replaceObjectAtIndex:selectedIndexPath.row withObject:contact];
                 NSArray* selectedArray = [NSArray arrayWithObject:selectedIndexPath];
                 [self.tableView reloadRowsAtIndexPaths:selectedArray withRowAnimation:UITableViewRowAnimationNone];

             }
             else{
             NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:self.contacts.count inSection:0];
             NSArray* pathArray = [NSArray arrayWithObject:newIndexPath];
             [self.contacts addObject:contact];
             [self.tableView insertRowsAtIndexPaths:pathArray withRowAnimation:UITableViewRowAnimationBottom];
             }
            [self saveContacts];
        NSLog(@"Shows what inside last added: %@",[[self.contacts objectAtIndex:self.contacts.count-1] photo]);
         }
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.contacts removeObjectAtIndex:indexPath.row];
        [self saveContacts];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier  isEqual: @"ShowDetail"]) {
        ContactViewController* contactDetailViewController = [segue destinationViewController];
        ContactTableViewCell* selectedContactCell = sender;
        if (selectedContactCell != NULL){
            NSIndexPath* indexPath = [self.tableView indexPathForCell:selectedContactCell];
            Contact* selectedContact = self.contacts[indexPath.row];
            contactDetailViewController.contact = selectedContact;
                                      
        }
        
    }
    else if ([segue.identifier  isEqual: @"AddItem"]){
        
        NSLog(@"Add new Item");
    }
}


// MARK: NSCoding

-(void)saveContacts{
    BOOL isSuccessfulSave = [NSKeyedArchiver archiveRootObject:self.contacts toFile:[[Contact ArchiveUrl] path]];
    if (!isSuccessfulSave) {
        NSLog(@"Failed to save meals");
    }
    
}

-(NSArray *)loadContacts{
    NSArray* contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:[[Contact ArchiveUrl] path]];
    return contacts;
}


-(void)saveRecentsFromAlert:(NSArray*)recents{
    BOOL isSuccessfulSave = [NSKeyedArchiver archiveRootObject:recents toFile:[[Recent ArchiveUrl] path]];
    if (!isSuccessfulSave) {
        NSLog(@"Failed to save recentss");
    }
    
}

-(NSArray *)loadRecents{
    NSArray* recents = [NSKeyedUnarchiver unarchiveObjectWithFile:[[Recent ArchiveUrl] path]];
    return recents;
}


- (IBAction)callContact:(UIButton*)sender {
    ContactTableViewCell* selectedContactCell = [[sender superview] superview];
    NSLog(@"%@", selectedContactCell);
    NSString* message = [NSString stringWithFormat:@"You are calling %@ \n %@", selectedContactCell.nameLabel.text,selectedContactCell.phoneNumberLabel.text];
    UIAlertController* youCallingWindow = [UIAlertController alertControllerWithTitle:@"Calling" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"was canceled");
    }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"End Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // save data into recents
        NSMutableArray* recents =[NSMutableArray arrayWithArray:[self loadRecents]];
        Recent* newRecent = [[Recent alloc] initWithName:selectedContactCell.nameLabel.text Image:selectedContactCell.photoImageView.image Date:[NSDate date] andPhoneNumber:selectedContactCell.phoneNumberLabel.text];
        [recents insertObject:newRecent atIndex:0];
        NSLog(@"Recents: %@", recents);
        [self saveRecentsFromAlert:recents];
        NSNotification *broadCastMessage = [NSNotification notificationWithName:@"broadcastMessage" object:self];
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotification:broadCastMessage];
    }];
    [youCallingWindow addAction:cancelAction];
    [youCallingWindow addAction:saveAction];
    [self presentViewController:youCallingWindow animated:true completion:nil];
}



@end
