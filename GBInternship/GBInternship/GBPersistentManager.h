//
//  GBPersistentManager.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBUser+CoreDataClass.h"

@interface GBPersistentManager : NSObject

+ (GBPersistentManager*) sharedManager;

// Get all avaliable sites
- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure;

// Get all persons with their ranks
- (void) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray* personsArray)) success
                                   onFailure: (void(^)(NSError* error)) failure;

// Get statistic by siteID
- (void) getStatisticBySiteID: (NSInteger) siteID
                    onSuccess: (void(^)(NSArray* statisticArray)) success
                    onFailure: (void(^)(NSError* error)) failure;


// Get daily statistic by siteID, personID and date
- (void) getArrayDailyBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
           andBetweenFirstDate: (NSDate*) firstDate
                    andEndDate: (NSDate*) endDate
                     onSuccess: (void(^)(NSArray* statisticArray)) success
                     onFailure: (void(^)(NSError* error)) failure;

//User's methods
- (BOOL) isUserExistAndCheckLogin: (NSString*) login andPassword: (NSString*) password;
- (void) saveUserWithLogin: (NSString*) login andPassword: (NSString*) password;
- (NSString*) userLastVisitDate: (NSString*) login;
- (void) saveUserLastDateWithLogin: (NSString*) login;
- (void) setUserCurrentState: (NSString*) login;
- (void) setAllUsersStatesToNO;
- (GBUser*) currentUser;

@end
