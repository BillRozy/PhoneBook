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

@interface MealTableViewController ()

@end

@implementation MealTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSampleMeals];
    NSLog(@"Array: %@", self.meals);
}

-(void)loadSampleMeals{
    UIImage* photo1 = [UIImage imageNamed:@"Dish1"];
    Meal* meal1 = [[Meal alloc] initWithName:@"Steak with something" Image:photo1 AndRating:4];
    
    UIImage* photo2 = [UIImage imageNamed:@"Dish2"];
    Meal* meal2 = [[Meal alloc] initWithName:@"Friies" Image:photo2 AndRating:5];
    
    UIImage* photo3 = [UIImage imageNamed:@"Dish3"];
    Meal* meal3 = [[Meal alloc] initWithName:@"Fat and Dirty" Image:photo3 AndRating:3];
    
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
    cell.ratingControl.rating = meal.rating;
    
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

@end
