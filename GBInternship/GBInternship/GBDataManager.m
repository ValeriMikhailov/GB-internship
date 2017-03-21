//
//  GBDataManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBDataManager.h"
#import "GBSitesCD+CoreDataClass.h"
#import "GBPersonCD+CoreDataProperties.h"
#import "GBStatistic+CoreDataClass.h"

@implementation GBDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize persistentContainer = _persistentContainer;

+ (GBDataManager*) sharedManager {
    
    static GBDataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GBDataManager alloc] init];
    });
    
    return manager;
}

#pragma mark - Saving methods -

- (void) saveSiteWithID:(NSInteger)ID andName:(NSString*)URL {
    
    BOOL duplicate = [self isEntityInCoreData:@"GBSitesCD" HasPredicate:@"siteURL" withValue:URL];
    
    if (!duplicate) {

        GBSitesCD* site = [NSEntityDescription insertNewObjectForEntityForName:@"GBSitesCD" inManagedObjectContext:self.managedObjectContext];
        site.siteID = ID;
        site.siteURL = URL;
        [site.managedObjectContext save:nil];
    }
}

- (void) savePersonWithID:(NSInteger)ID andName:(NSString*)name {
    
    BOOL duplicate = [self isEntityInCoreData:@"GBPersonCD" HasPredicate:@"personName" withValue:name];
    
    if (!duplicate) {
        
        GBPersonCD* person = [NSEntityDescription insertNewObjectForEntityForName:@"GBPersonCD" inManagedObjectContext:self.managedObjectContext];
        person.personID = ID;
        person.personName = name;
        [person.managedObjectContext save:nil];
    }
}

- (void) saveStatisticWithSiteID:(NSInteger)ID
                   andPersonName:(NSString*)name
                         andRank:(NSInteger)rank {
    
    
}

#pragma mark - Fetch from DB methods - 


#pragma mark - Helpful methods -

- (NSArray*) allObjectsByEntityName:(NSString*)string {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:string inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) deleteAllObjectsByEntityName:(NSString*)string {
    
    NSArray* allObjects = [self allObjectsByEntityName:string];
    
    for (id object in allObjects) {
        
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
}

- (BOOL) isEntityInCoreData:(NSString*)entity
               HasPredicate:(NSString*)predicate
                  withValue:(NSString*)value {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:entity
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"%@ == %d", predicate, value]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    return count > 0 ? YES : NO;
}

#pragma mark - Core Data stack

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"GBInternship"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSPersistentStoreCoordinator*) persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL* storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GBInternship.sqlite"];
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
