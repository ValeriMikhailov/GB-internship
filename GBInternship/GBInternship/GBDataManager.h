//
//  GBDataManager.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GBDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistantStoreCoordinator;

+ (GBDataManager*) sharedManager;

- (void) saveContext;

@end
