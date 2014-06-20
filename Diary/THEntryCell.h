//
//  THEntryCell.h
//  Diary
//
//  Created by Anthony Armstrong on 6/19/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THDiaryEntry;

@interface THEntryCell : UITableViewCell


+ (CGFloat)heightForEntry:(THDiaryEntry*) entry;
@end
