//
//  GBDataManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBDataManager.h"

@implementation GBDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistantStoreCoordinator = _persistantStoreCoordinator;

+ (GBDataManager*) sharedManager {
    
    static GBDataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GBDataManager alloc] init];
    });
    
    return manager;
}
#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (context != nil) {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
