//
//  THCoreDataStack.h
//  Diary
//
//  Created by Anthony Armstrong on 6/14/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface THCoreDataStack : NSObject



@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//Create singleton init
+ (instancetype) defaultStack;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
