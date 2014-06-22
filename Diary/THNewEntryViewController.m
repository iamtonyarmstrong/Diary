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
#import <CoreLocation/CoreLocation.h>


@interface THNewEntryViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, assign) enum THDiaryEntryMood pickedMood;
@property (weak, nonatomic) IBOutlet UIButton * badButton;
@property (weak, nonatomic) IBOutlet UIButton * averageButton;
@property (weak, nonatomic) IBOutlet UIButton * goodButton;
@property (strong, nonatomic) IBOutlet UIView *accessoryView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (nonatomic, strong) UIImage * pickedImage;

@end

@implementation THNewEntryViewController

#pragma mark - default methods for generating the view
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSDate * date;
    if(self.entry != nil){
        self.textView.text = self.entry.body;
        self.pickedMood = self.entry.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entry.date];
    } else {
        self.pickedMood = THDiaryEntryMoodAverage;
        date = [NSDate date];
        [self loadLocation];

    }

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [dateFormatter stringFromDate:date];

    //This view (self.accessoryView) is not in the view heirarchy when the view is drawn
    //The call here, only creates the buttons for selecting mood when the user enters a new post,
    //and will only appear when the keyboard appears.
    self.textView.inputAccessoryView = self.accessoryView;

    //Round the image in the button, using the CALayer. Make sure that you set "Clips Subview" for the button
    self.selectImageButton.layer.cornerRadius = CGRectGetWidth(self.selectImageButton.frame)/2.0f;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location methods
- (void) loadLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Called loadLocation");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = 1000; //1km of desired accuracy (about .62 miles)
        [self.locationManager startUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    CLLocation * location = [locations firstObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       CLPlacemark * placemark = [placemarks firstObject];
                       //self.location = placemark.name; placemark.locality;
                       NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"%@, %@", placemark.name, placemark.locality];
                       self.location = str;
                  }];
}



#pragma mark - Updating Diary entry elements
- (void) updateDiaryEntry
{
    self.entry.body = self.textView.text;
    THCoreDataStack *coreDataStack = [THCoreDataStack defaultStack];
    [coreDataStack saveContext];
}

- (void) setPickedMood:(enum THDiaryEntryMood)pickedMood
{
    _pickedMood = pickedMood;
    self.badButton.alpha = 0.3f;
    self.goodButton.alpha = 0.3f;
    self.averageButton.alpha = 0.3f;

    switch (pickedMood) {
        case THDiaryEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;

        case THDiaryEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            break;

        case THDiaryEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;

        default:
            self.badButton.alpha = 0.3f;
            self.goodButton.alpha = 0.3f;
            self.averageButton.alpha = 0.3f;
            break;
    }
}

- (void) setPickedImage:(UIImage *)pickedImage
{
    _pickedImage = pickedImage;
    if (_pickedImage == nil){
        [self.selectImageButton setImage:[UIImage imageNamed:@"icn_noimage"]
                                forState:UIControlStateNormal];
    } else {
        [self.selectImageButton setImage:pickedImage
                                forState:UIControlStateNormal];
        
    }
    
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

- (IBAction)cancelWasPressed:(id)sender
{
    [self dismissSelf];
}

- (void)insertNewDiaryEntry
{
    THCoreDataStack *coreDataStack = [THCoreDataStack defaultStack];
    THDiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"THDiaryEntry"
                                                        inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textView.text;
    entry.date = [[NSDate date]timeIntervalSince1970];
    entry.mood = _pickedMood;
    entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.80);
    entry.location = self.location;
    [coreDataStack saveContext];

}

- (void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (IBAction)badWasPressed:(id)sender
{
    self.pickedMood = THDiaryEntryMoodBad;
}

- (IBAction)averageWasPressed:(id)sender
{
    self.pickedMood = THDiaryEntryMoodAverage;
}

- (IBAction)goodWasPressed:(id)sender
{
    self.pickedMood = THDiaryEntryMoodGood;
}

- (IBAction)imageButtonWasPressed:(id)sender
{
     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
         [self promptForSource];
     } else {
         [self promptForPhotoRollImage];
     }
}


#pragma mark - Camera and Image methods
- (void) promptForSource
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"Image Source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Photo Roll", nil];

    [actionSheet showInView:self.view];

}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex == actionSheet.firstOtherButtonIndex){
            [self promptForCamera];
        } else {
            [self promptForPhotoRollImage];
        }
    }
}

- (void) promptForCamera
{
    UIImagePickerController * controller = [[UIImagePickerController alloc]init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion: nil];
}

- (void) promptForPhotoRollImage
{
    UIImagePickerController * controller = [[UIImagePickerController alloc]init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion: nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
