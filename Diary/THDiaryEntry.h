//
//  THDiaryEntry.h
//  Diary
//
//  Created by Anthony Armstrong on 6/14/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ENUM(int16_t, THDiaryEntryMood){
    THDiaryEntryMoodGood = 0,
    THDiaryEntryMoodAverage = 1,
    THDiaryEntryModdBad = 2
};

@interface THDiaryEntry : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic) int16_t mood;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, readonly) NSString * sectionName;
@end
