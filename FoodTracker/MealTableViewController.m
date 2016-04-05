//
//  MealTableViewController.m
//  FoodTracker
//
//  Created by fd on 02/04/16.
//  Copyright (c) 2016 fd. All rights reserved.
//

#import "MealTableViewController.h"
#import "Meal.h"
#import "MealTableViewCell.h"
#import "MealViewController.h"

@interface MealTableViewController ()

@end

@implementation MealTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
   NSArray* savedMeals = [self loadMeals];
    NSMutableArray* resulter = [NSMutableArray arrayWithArray:savedMeals];
    if(![savedMeals isEqualToArray:@[]])
    {
        
        self.meals = resulter;
   }
    else
    {
    
    [self loadSampleMeals];
    }
    NSLog(@"WHAT INSIDE? %@ %@ %@",[self.meals.firstObject name],[self.meals.firstObject photo], [self.meals.firstObject phoneNumber]);
  }

-(void)loadSampleMeals{
    UIImage* photo1 = [UIImage imageNamed:@"Dish1"];
    Meal* meal1 = [[Meal alloc] initWithName:@"Steak with something" Image:photo1 andPhoneNumber:@"89087517220"];
    
    UIImage* photo2 = [UIImage imageNamed:@"Dish2"];
    Meal* meal2 = [[Meal alloc] initWithName:@"Friies" Image:photo2 andPhoneNumber:@"89601825549"];
    
    UIImage* photo3 = [UIImage imageNamed:@"Dish3"];
    Meal* meal3 = [[Meal alloc] initWithName:@"Fat and Dirty" Image:photo3 andPhoneNumber:@"89307653651"];
    
    self.meals = [[NSMutableArray alloc] initWithArray:@[meal1, meal2, meal3]];
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
    return [self.meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier = @"MealTableViewCell";

    MealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Meal* meal = [self.meals objectAtIndex:indexPath.row];
    cell.nameLabel.text = meal.name;
    cell.photoImageView.image = meal.photo;
    cell.phoneNumberLabel.text = meal.phoneNumber;
    return cell;
}

// MARK: navigation

-(void)unwindToMealList:(UIStoryboardSegue *)sender{
    MealViewController* sourceViewController = sender.sourceViewController;
    Meal* meal = sourceViewController.meal;
    if (sourceViewController != nil && meal != nil)
    { NSIndexPath* selectedIndexPath = self.tableView.indexPathForSelectedRow;
             if (selectedIndexPath) {
                 [self.meals replaceObjectAtIndex:selectedIndexPath.row withObject:meal];
                 NSArray* selectedArray = [NSArray arrayWithObject:selectedIndexPath];
                 [self.tableView reloadRowsAtIndexPaths:selectedArray withRowAnimation:UITableViewRowAnimationNone];
                 
             }
             else{
             NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:self.meals.count inSection:0];
             NSArray* pathArray = [NSArray arrayWithObject:newIndexPath];
             [self.meals addObject:meal];
             [self.tableView insertRowsAtIndexPaths:pathArray withRowAnimation:UITableViewRowAnimationBottom];
             }
        [self saveMeals];
        NSLog(@" %@ %@", meal.name,meal.photo);
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
        [self.meals removeObjectAtIndex:indexPath.row];
        [self saveMeals];
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
        MealViewController* mealDetailViewController = [segue destinationViewController];
        MealTableViewCell* selectedMealCell = sender;
        if (selectedMealCell != NULL){
            NSIndexPath* indexPath = [self.tableView indexPathForCell:selectedMealCell];
            Meal* selectedMeal = self.meals[indexPath.row];
            mealDetailViewController.meal = selectedMeal;
                                      
        }
        
    }
    else if ([segue.identifier  isEqual: @"AddItem"]){
        
        NSLog(@"Add new Item");
    }
}


// MARK: NSCoding

-(void)saveMeals{
    BOOL isSuccessfulSave = [NSKeyedArchiver archiveRootObject:self.meals toFile:[[Meal ArchiveUrl] path]];
    if (!isSuccessfulSave) {
        NSLog(@"Failed to save meals");
    }
    
}

-(NSArray *)loadMeals{
    NSArray* meals = [NSKeyedUnarchiver unarchiveObjectWithFile:[[Meal ArchiveUrl] path]];
    return meals;
}

- (IBAction)callContact:(UIButton*)sender {
    MealTableViewCell* selectedMealCell = [[sender superview] superview];
    NSLog(@"%@", selectedMealCell);
    NSString* message = [NSString stringWithFormat:@"You are calling %@ \n %@", selectedMealCell.nameLabel.text,selectedMealCell.phoneNumberLabel.text];
    UIAlertController* youCallingWindow = [UIAlertController alertControllerWithTitle:@"Calling" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"End Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [youCallingWindow addAction:cancelAction];
    [youCallingWindow addAction:saveAction];
    [self presentViewController:youCallingWindow animated:true completion:nil];
}



@end
