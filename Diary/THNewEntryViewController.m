//
//  THNewEntryViewController.m
//  Diary
//
//  Created by Anthony Armstrong on 6/15/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "THNewEntryViewController.h"
#import "THCoreDataStack.h"
#import "THDiaryEntry.h"

@interface THNewEntryViewController ()

@end

@implementation THNewEntryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods
- (IBAction)doneWasPressed:(id)sender
{
    [self insertNewDiaryEntry];
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender
{
    [self dismissSelf];
}

- (void)insertNewDiaryEntry
{
    THCoreDataStack *coreDataStack = [THCoreDataStack defaultStack];
    THDiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"THDiaryEntry"
                                                        inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textField.text;
    entry.date = [[NSDate date]timeIntervalSince1970];
    [coreDataStack saveContext];

}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:^(void){
                                                          NSLog(@"Dismissed controller");
                                                      }];
}

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
