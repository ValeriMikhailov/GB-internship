//
//  GBDataManager.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "GBUser+CoreDataClass.h"

@interface GBDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (GBDataManager*) sharedManager;

- (void) saveSiteWithID:(NSInteger)ID andName:(NSString*)URL;
- (void) savePersonWithID:(NSInteger)ID andName:(NSString*)name;
- (void) saveStatisticWithSiteID:(NSInteger)ID
                   andPersonName:(NSString*)name
                    andStartDate:(NSDate*) startDate
                         andRank:(NSInteger)rank;
- (void) saveDailyStatBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
                       andDate: (NSDate*) date
                       andRank:(NSInteger)rank;

- (NSArray*) allStatisticForSite: (NSInteger) siteID;

- (NSArray*) allObjectsByEntityName:(NSString*)string;
- (void) deleteAllObjectsByEntityName:(NSString*)string;
- (void) saveContext;

#pragma mark - For Persistent - 
- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure;
- (void) getArrayOfAvaliablePersosnsOnSuccess: (void(^)(NSArray* personsArray)) success
                                    onFailure: (void(^)(NSError* error)) failure;
- (void) getArrayBySiteID: (NSInteger) siteID
                onSuccess: (void(^)(NSArray* statisticArray)) success
                onFailure: (void(^)(NSError* error)) failure;
- (void) getArrayDailyBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
           andBetweenFirstDate: (NSDate*) firstDate
                    andEndDate: (NSDate*) endDate
                     onSuccess: (void(^)(NSArray* statisticArray)) success
                     onFailure: (void(^)(NSError* error)) failure;

#pragma mark - User's entity methods - 
- (GBUser*) userFromDBWithLogin:(NSString*) login;
- (void) saveUserWithLogin: (NSString*) login andPassword: (NSString*) password;
- (NSDate*) userLastVisitDateWithLogin: (NSString*) login;
- (void) saveUserLastDateVisitWithLogin: (NSString*) login;
- (void) setUserCurrentState: (NSString*) login;
- (void) setAllUsersStatesToNo;
- (GBUser*) currentUser;

@end
