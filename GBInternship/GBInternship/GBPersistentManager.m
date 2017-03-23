//
//  GBPersistentManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPersistentManager.h"
#import "GBServerManager.h"
#import "GBDataManager.h"
#import "GBSite+CoreDataClass.h"
#import "GBStatistic+CoreDataClass.h"
#import "GBPerson+CoreDataClass.h"
#import "GBSiteAPI.h"
#import "GBPersonAPI.h"
#import "GBStatisticAPI.h"

@interface GBPersistentManager ()

@end

@implementation GBPersistentManager

- (id)init {
    
    self = [super init];
    if (self) {
        
    } return self;
}

+ (GBPersistentManager*) sharedManager {
    
    static GBPersistentManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        manager = [[GBPersistentManager alloc] init];
        
    });
    
    return manager;
}

// Get all avaliable sites

- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure {
    
    if ([self isHasDB:@"SiteDB"]) {
        // Get data from DB
        [[GBDataManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
            if (success) {
                success(sitesArray);
            }
        } onFailure:^(NSError *error) {
        }];
        
    } else {
        
        // Get data from Server
        [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
            
            for (GBSiteAPI* obj in sitesArray) {
                // Save data in DB
                [[GBDataManager sharedManager] saveSiteWithID:obj.siteID andName:obj.siteURL];
            }
            
            if (success) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SiteDB"];
                success(sitesArray);
            }
        } onFailure:^(NSError *error) {
        }];
    }
}

// Get all persons with their ranks
- (void) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray* personsArray)) success
                                   onFailure: (void(^)(NSError* error)) failure {
    
    if ([self isHasDB:@"PersonDB"]) {
        // Get data from DB
        [[GBDataManager sharedManager] getArrayOfAvaliablePersosnsOnSuccess:^(NSArray *personsArray) {
            if (success) {
                success(personsArray);
            }
        } onFailure:^(NSError *error) {
            
        }];
        
    } else {
        
        // Get data from Server
        [[GBServerManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
            
            for (GBPerson* obj in personsArray) {
                // Save data in DB
                [[GBDataManager sharedManager] savePersonWithID:obj.personID andName:obj.personName];
            }
            
            if (success) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PersonDB"];
                success(personsArray);
            }
        } onFailure:^(NSError *error) {
        }];
    }
}

// Get statistic by siteID
- (void) getStatisticBySiteID: (NSInteger) siteID
                    onSuccess: (void(^)(NSArray* statisticArray)) success
                    onFailure: (void(^)(NSError* error)) failure {
    
    if ([self isHasDB:@"StatisticDB"]) {
        // Get data from DB
        [[GBDataManager sharedManager] getArrayBySiteID:siteID
                                              onSuccess:^(NSArray *statisticArray) {
                                                  if (success) {
                                                      success(statisticArray);
                                                  }
                                              } onFailure:^(NSError *error) {
                                                  
                                              }];
    } else {
        
        // Get data from Server
        [[GBServerManager sharedManager]
         getArrayBySiteID:siteID
         onSuccess:^(NSArray *statisticArray) {
             for (GBPerson* obj in statisticArray) {
                 
                 NSArray* arr = [NSArray arrayWithArray:[obj.statistic allObjects]];
                 GBStatistic* stat = [arr firstObject];
                 
                 [[GBDataManager sharedManager]
                  saveStatisticWithSiteID:siteID
                  andPersonName:obj.personName
                  andStartDate:stat.startDate andRank:stat.rank];
             }
             if (success) {
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"StatisticDB"];
                 success(statisticArray);
             }
         } onFailure:^(NSError *error) {
         }];
    }
}

// Get daily statistic by siteID, personID and date
- (void) getArrayDailyBySiteID: (NSInteger) siteID
                   andPersonID: (NSInteger) personID
           andBetweenFirstDate: (NSDate*) firstDate
                    andEndDate: (NSDate*) endDate
                     onSuccess: (void(^)(NSArray* statisticArray)) success
                     onFailure: (void(^)(NSError* error)) failure {
    
    if ([self isHasDB:@"StatisticDailyDB"]) {
        // Get data from DB
        [[GBDataManager sharedManager] getArrayDailyBySiteID:siteID
                                                 andPersonID:personID
                                         andBetweenFirstDate:firstDate
                                                  andEndDate:endDate
                                                   onSuccess:^(NSArray *statisticArray) {
                                            
                                                   } onFailure:^(NSError *error) {
                                                       
                                                   }];
    } else {
        
        // Get data from Server
        [[GBServerManager sharedManager]
         getArrayDailyBySiteID:siteID
         andPersonID:personID
         andBetweenFirstDate:firstDate
         andEndDate:endDate
         onSuccess:^(NSArray *statisticArray) {
             for (GBStatistic* stat in statisticArray) {
                 
                 [[GBDataManager sharedManager] saveDailyStatBySiteID:siteID
                                                          andPersonID:personID
                                                              andDate:stat.date
                                                              andRank:stat.rank];
             }
             
             if (success) {
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"StatisticDailyDB"];
                 success(statisticArray);
             }
         } onFailure:^(NSError *error) {
            
         }];
    }

    
}

#pragma nark - Helpful methods - 

- (BOOL) connectedToInternet {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSASCIIStringEncoding error:nil];
    
    ( URLString != NULL ) ? NSLog(@"connection good") : NSLog(@"connection bad");
    return ( URLString != NULL ) ? YES : NO;
}

- (BOOL) connectedToOurServer {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://52.89.213.205"] encoding:NSASCIIStringEncoding error:nil];
    
    ( URLString != NULL ) ? NSLog(@"connection good") : NSLog(@"connection bad");
    return ( URLString != NULL ) ? YES : NO;
}

- (BOOL) shouldUpdateDataFromServer {
    
    return YES;
}

- (BOOL) isHasDB:(NSString*)entity {
    
    return ([[NSUserDefaults standardUserDefaults] boolForKey:entity]) ? YES : NO;
}

@end
