//
//  THNewEntryViewController.h
//  Diary
//
//  Created by Anthony Armstrong on 6/15/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THDiaryEntry;

@interface THNewEntryViewController : UIViewController


@property (nonatomic, strong) THDiaryEntry * entry;
@property (weak, nonatomic) IBOutlet UITextView * textView;


@end
