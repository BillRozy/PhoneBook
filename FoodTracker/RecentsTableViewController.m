//
//  RecentsTableViewController.m
//  FoodTracker
//
//  Created by fd on 07/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "RecentsTableViewController.h"
#import "Recent.h"
#import "RecentTableViewCell.h"

@interface RecentsTableViewController ()
- (IBAction)callSameContact:(UIButton *)sender;
- (IBAction)cleanRecentsHistory:(UIButton *)sender;

@end

@implementation RecentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSArray* savedRecents = [self loadRecents];
    NSMutableArray* resulter = [NSMutableArray arrayWithArray:savedRecents];
    if(![savedRecents isEqualToArray:@[]])
    {
        
    self.recents = resulter;
        
    }

    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(updaterOfRecentsCells) name:@"broadcastMessage" object:nil];
    NSLog(@"notification center was added %@", notificationCenter);
}

-(void)updaterOfRecentsCells{
    NSLog(@"Button pressed %@", self.tableView);
    self.recents = [NSMutableArray arrayWithArray:[self loadRecents]];
    [self.tableView beginUpdates];
     
     [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
     
     [self.tableView endUpdates];
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
    return [self.recents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"RecentTableViewCell";
    
    RecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Recent* recent = [self.recents objectAtIndex:indexPath.row];
    cell.nameLabel.text = recent.name;
    cell.photoImageView.image = recent.photo;
    cell.phoneNumberLabel.text = recent.phoneNumber;
    cell.dateLabel.text = [NSDateFormatter localizedStringFromDate:recent.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: NSCoding

-(void)saveRecents{
    BOOL isSuccessfulSave = [NSKeyedArchiver archiveRootObject:self.recents toFile:[[Recent ArchiveUrl] path]];
    if (!isSuccessfulSave) {
        NSLog(@"Failed to save recentss");
    }
    
}

-(NSArray *)loadRecents{
    NSArray* recents = [NSKeyedUnarchiver unarchiveObjectWithFile:[[Recent ArchiveUrl] path]];
    return recents;
}



// MARK: actions

- (IBAction)callSameContact:(UIButton *)sender {
    RecentTableViewCell* selectedRecentCell = [[sender superview] superview];
    NSLog(@"%@", selectedRecentCell);
    NSString* message = [NSString stringWithFormat:@"You are calling %@ \n %@", selectedRecentCell.nameLabel.text,selectedRecentCell.phoneNumberLabel.text];
    UIAlertController* youCallingWindow = [UIAlertController alertControllerWithTitle:@"Calling" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"was canceled");
    }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"End Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // save data into recents
        Recent* newRecent = [[Recent alloc] initWithName:selectedRecentCell.nameLabel.text Image:selectedRecentCell.photoImageView.image Date:[NSDate date] andPhoneNumber:selectedRecentCell.phoneNumberLabel.text];
        [self.recents insertObject:newRecent atIndex:0];
        [self saveRecents];
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];}];
    [youCallingWindow addAction:cancelAction];
    [youCallingWindow addAction:saveAction];
    [self presentViewController:youCallingWindow animated:true completion:nil];
}

- (IBAction)cleanRecentsHistory:(UIButton *)sender {
    [self.recents removeAllObjects];
    [self saveRecents];
    [self.tableView reloadData];
    NSLog(@"recents were deleted");
}

@end
