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
    if(self.entry != nil){
        self.textField.text = self.entry.body;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods
- (IBAction)doneWasPressed:(id)sender
{
    if(self.entry != nil){
        [self updateDiaryEntry];
    } else {
        [self insertNewDiaryEntry];
    }
    [self dismissSelf];
}


- (void) updateDiaryEntry
{
    self.entry.body = self.textField.text;
    THCoreDataStack *coreDataStack = [THCoreDataStack defaultStack];
    [coreDataStack saveContext];
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





@end
