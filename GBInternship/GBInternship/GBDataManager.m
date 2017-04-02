//
//  GBDataManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBDataManager.h"
#import "GBSite+CoreDataClass.h"
#import "GBPerson+CoreDataClass.h"
#import "GBStatistic+CoreDataClass.h"
#import "GBUser+CoreDataClass.h"

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
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBSite"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"siteURL == %@", URL]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    BOOL duplicate = count > 0 ? YES : NO;
    
    if (!duplicate) {

        GBSite* site = [NSEntityDescription insertNewObjectForEntityForName:@"GBSite" inManagedObjectContext:self.managedObjectContext];
        site.siteID = ID;
        site.siteURL = URL;
        [site.managedObjectContext save:nil];
    }
}

- (void) savePersonWithID:(NSInteger)ID andName:(NSString*)name {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBPerson"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"personName == %@", name]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    BOOL duplicate = count > 0 ? YES : NO;
    
    if (!duplicate) {
        
        GBPerson* person = [NSEntityDescription insertNewObjectForEntityForName:@"GBPerson" inManagedObjectContext:self.managedObjectContext];
        person.personID = ID;
        person.personName = name;
        [person.managedObjectContext save:nil];
    }
}

- (void) saveStatisticWithSiteID:(NSInteger)ID
                   andPersonName:(NSString*)name
                    andStartDate:(NSDate*) startDate
                         andRank:(NSInteger)rank {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBStatistic"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"persons.personName == %@ AND startDate == %@ AND sites.siteID == %d", name, startDate, ID]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    BOOL duplicate = count > 0 ? YES : NO;
    
    if (!duplicate) {
        
        GBStatistic* statistic = [NSEntityDescription insertNewObjectForEntityForName:@"GBStatistic" inManagedObjectContext:self.managedObjectContext];
        
        // Get person entity
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBPerson" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        [request setPredicate:[NSPredicate predicateWithFormat:@"personName == %@", name]];
        NSArray* persons = [self.managedObjectContext executeFetchRequest:request error:nil];
        GBPerson* person = [persons firstObject];
        
        // Get site entity
        NSEntityDescription* entity2 = [NSEntityDescription entityForName:@"GBSite" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest* request2 = [[NSFetchRequest alloc] init];
        [request2 setEntity:entity2];
        [request2 setPredicate:[NSPredicate predicateWithFormat:@"siteID == %d", ID]];
        NSArray* sites = [self.managedObjectContext executeFetchRequest:request2 error:nil];
        GBSite* site = [sites firstObject];
        
        statistic.persons = person;
        statistic.sites = site;
        statistic.rank = rank;
        statistic.startDate = startDate;
        statistic.date = [self dateFromString:@"0000-00-00"];
        [statistic.managedObjectContext save:nil];
    }
    
    
}

- (void) saveDailyStatBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
                       andDate: (NSDate*) date
                       andRank: (NSInteger) rank {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBStatistic"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"sites.siteID == %d AND persons.personID == %d AND date == %@", siteID, personID, date]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    BOOL duplicate = count > 0 ? YES : NO;
    
    if (!duplicate) {
    
        GBStatistic* statistic =
        [NSEntityDescription insertNewObjectForEntityForName:@"GBStatistic"
                                      inManagedObjectContext:self.managedObjectContext];
        
        // Get person entity
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBPerson" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        [request setPredicate:[NSPredicate predicateWithFormat:@"personID == %d", personID]];
        NSArray* persons = [self.managedObjectContext executeFetchRequest:request error:nil];
        //NSLog(@"%lu", (unsigned long)persons.count);
        GBPerson* person = [persons firstObject];
        
        // Get site entity
        NSEntityDescription* entity2 = [NSEntityDescription entityForName:@"GBSite" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest* request2 = [[NSFetchRequest alloc] init];
        [request2 setEntity:entity2];
        [request2 setPredicate:[NSPredicate predicateWithFormat:@"siteID == %d", siteID]];
        NSArray* sites = [self.managedObjectContext executeFetchRequest:request2 error:nil];
        //NSLog(@"%lu", (unsigned long)sites.count);
        GBSite* site = [sites firstObject];
        NSLog(@"%@", site.siteURL);
        
        statistic.rank = rank;
        statistic.date = date;
        statistic.persons = person;
        statistic.sites = site;
        statistic.startDate = [self dateFromString:@"0000-00-00"];
        [statistic.managedObjectContext save:nil];
    }
}

- (void) setUserCurrentState: (NSString*) login {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBUser"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginName = %@", login]];
    NSArray* users = [self.managedObjectContext executeFetchRequest:request error:nil];
    //NSLog(@"%lu", (unsigned long)sites.count);
    GBUser* user = [users firstObject];
    user.isCurrent = YES;
    [user.managedObjectContext save:nil];
}

- (void) setAllUsersStatesToNo {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBUser"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"isCurrent == YES"]];
    NSArray* users = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"%lu", (unsigned long)users.count);
    
    for (GBUser* usr in users) {
        usr.isCurrent = NO;
        usr.lastVisitDate = [NSDate date];
        [usr.managedObjectContext save:nil];
    }
    
}

- (void) saveUserWithLogin: (NSString*) login andPassword: (NSString*) password {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBUser"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginName = %@", login]];
    
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    BOOL duplicate = count > 0 ? YES : NO;
    
    if (!duplicate) {
        
        // Set newUser ID
        NSEntityDescription* entity2 = [NSEntityDescription entityForName:@"GBUser" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest* request2 = [[NSFetchRequest alloc] init];
        [request2 setEntity:entity2];
        NSArray* users = [self.managedObjectContext executeFetchRequest:request2 error:nil];
        NSLog(@"%lu", (unsigned long)users.count);
        GBUser* user =
        [NSEntityDescription insertNewObjectForEntityForName:@"GBUser"
                                      inManagedObjectContext:self.managedObjectContext];
        user.userID = users.count + 1;
        NSLog(@"%d", user.userID);
        
        user.loginName = login;
        NSLog(@"%@", user.loginName);
        user.password = password;
        NSLog(@"%@", user.password);
        
        [user.managedObjectContext save:nil];
        
        //check how much of users are in DB
//        NSEntityDescription* entity3 = [NSEntityDescription entityForName:@"GBUser" inManagedObjectContext:self.managedObjectContext];
//        NSFetchRequest* request3 = [[NSFetchRequest alloc] init];
//        [request3 setEntity:entity3];
//        NSArray* users2 = [self.managedObjectContext executeFetchRequest:request3 error:nil];
        //NSLog(@"%lu", (unsigned long)users2.count);
    } 
}

- (void) saveUserLastDateVisitWithLogin: (NSString*) login {
    
    NSEntityDescription* entityObject =
    [NSEntityDescription entityForName:@"GBUser"
                inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entityObject];
    [request setFetchLimit:1];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginName = %@", login]];
    NSArray* users = [self.managedObjectContext executeFetchRequest:request error:nil];
    //NSLog(@"%lu", (unsigned long)sites.count);
    GBUser* user = [users firstObject];
    user.lastVisitDate = [NSDate date];
    //NSLog(@"\n\n\n\n\n\nuser last visit is: %@", user.lastVisitDate);
    [user.managedObjectContext save:nil];
}

#pragma mark - Fetch from DB methods -

- (NSArray*) allStatisticForSite: (NSInteger) siteID {

    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBStatistic" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"sites.siteID == %d AND startDate != nil", siteID]];
    NSArray* stat = [self.managedObjectContext executeFetchRequest:request error:nil];
    return stat;
}

- (NSArray*) dailyStatisticForSite: (NSInteger) siteID
                         andPerson: (NSInteger) personID
                       andDateFrom: (NSDate*) startDate
                       andDateTill: (NSDate*) endDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startOfDay = [calendar dateBySettingHour:0
                                              minute:0
                                              second:0 ofDate:startDate options:0];
    NSDate *endOfDay = [calendar dateBySettingHour:23
                                            minute:59
                                            second:59 ofDate:endDate options:0];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBStatistic" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"sites.siteID == %d AND persons.personID == %d AND date >= %@ AND date <= %@", siteID, personID, startOfDay, endOfDay]];
    NSArray* stat = [self.managedObjectContext executeFetchRequest:request error:nil];
    return stat;
}

- (GBUser*) userFromDBWithLogin:(NSString*) login {

    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBUser" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginName == %@", login]];
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:nil];
    return [arr firstObject];
}

- (GBUser*) currentUser {
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBUser" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"isCurrent == YES"]];
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:nil];
    return [arr firstObject];
}

- (NSDate*) userLastVisitDateWithLogin: (NSString*) login {
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"GBUser" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginName == %@", login]];
    NSArray* arr = [self.managedObjectContext executeFetchRequest:request error:nil];
    GBUser* user = [arr firstObject];
    //NSLog(@"\n\n\n\n\n\n\nuser last visit in DB: %@", user.lastVisitDate);
    return user.lastVisitDate;
}


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

#pragma mark - For Persistent - 
- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure {
    NSArray* sites = [self allObjectsByEntityName:@"GBSite"];
    if (success) {
        success(sites);
    }
}

- (void) getArrayOfAvaliablePersosnsOnSuccess: (void(^)(NSArray* personsArray)) success
                                    onFailure: (void(^)(NSError* error)) failure {
    NSArray* persons = [self allObjectsByEntityName:@"GBPerson"];
    if (success) {
        success(persons);
    }
}

- (void) getArrayBySiteID: (NSInteger) siteID
                onSuccess: (void(^)(NSArray* statisticArray)) success
                onFailure: (void(^)(NSError* error)) failure {
    
    NSArray* stat = [self allStatisticForSite:siteID];
    if (success) {
        success(stat);
    }
}

- (void) getArrayDailyBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
           andBetweenFirstDate: (NSDate*) firstDate
                    andEndDate: (NSDate*) endDate
                     onSuccess: (void(^)(NSArray* statisticArray)) success
                     onFailure: (void(^)(NSError* error)) failure {
    
    NSArray* stat = [self dailyStatisticForSite:siteID andPerson:personID andDateFrom:firstDate andDateTill:endDate];
    if (success) {
        success(stat);
    }
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



- (NSDate*) dateFromString:(NSString*) string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter dateFromString:string];
}


@end
