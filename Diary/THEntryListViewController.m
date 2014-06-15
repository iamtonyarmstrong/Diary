//
//  THEntryListViewController.m
//  Diary
//
//  Created by Anthony Armstrong on 6/15/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "THEntryListViewController.h"
#import "THCoreDataStack.h"
#import "THDiaryEntry.h"

@interface THEntryListViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation THEntryListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self.fetchedResultsController performFetch:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core Data Methods

- (NSFetchRequest *)entryListFetchRequest
{
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"THDiaryEntry"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: @"date"
                                                                   ascending:NO ]];

    return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if(_fetchedResultsController != nil){
        return _fetchedResultsController;
    }

    THCoreDataStack *coreDataStack = [THCoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];

    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:coreDataStack.managedObjectContext
                                                                     sectionNameKeyPath:@"sectionName"
                                                                              cacheName:nil];

    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    THDiaryEntry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = entry.body;
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
