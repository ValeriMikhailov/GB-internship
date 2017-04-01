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
#import "GBStatistic+CoreDataProperties.h"


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
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"FetchedSites"
                 object:self];
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
        
        NSMutableArray* arr = [NSMutableArray array];
        // Get data from Server
        [[GBServerManager sharedManager]
         getArrayBySiteID:siteID
         onSuccess:^(NSArray *statisticArray) {
             for (GBStatisticAPI* obj in statisticArray) {
                 NSManagedObjectContext* ctx = [[GBDataManager sharedManager] managedObjectContext];
                 NSEntityDescription *entity = [NSEntityDescription entityForName:@"GBStatistic"
                                                           inManagedObjectContext:ctx];
                 GBStatistic *stat = [(GBStatistic*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:ctx];
                 stat.sites.siteID = siteID;
                 stat.persons.personName = obj.personName;
                 stat.startDate = obj.startDate;
                 stat.rank = obj.rank;
                 [arr addObject:stat];
                 [[GBDataManager sharedManager]
                  saveStatisticWithSiteID:siteID
                  andPersonName:obj.personName
                  andStartDate:obj.startDate andRank:obj.rank];
             }
             if (success) {
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"StatisticDB"];
                 success(arr);
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
    NSString* dbKey = [NSString stringWithFormat:@"StatisticDailyDB%ld%ld%@%@", (long)personID, (long)siteID, firstDate, endDate];
    if ([self isHasDB:dbKey]) {
        // Get data from DB
        [[GBDataManager sharedManager] getArrayDailyBySiteID:siteID
                                                 andPersonID:personID
                                         andBetweenFirstDate:firstDate
                                                  andEndDate:endDate
                                                   onSuccess:^(NSArray *statisticArray) {
                                                       if (success) {
                                                           success(statisticArray);
                                                       }
                                                   } onFailure:^(NSError *error) {
                                                       
                                                   }];
    } else {
        NSMutableArray* arr = [NSMutableArray array];
        // Get data from Server
        [[GBServerManager sharedManager]
         getArrayDailyBySiteID:siteID
         andPersonID:personID
         andBetweenFirstDate:firstDate
         andEndDate:endDate
         onSuccess:^(NSArray *statisticArray) {
             for (GBStatistic* obj in statisticArray) {
                 NSManagedObjectContext* ctx = [[GBDataManager sharedManager] managedObjectContext];
                 NSEntityDescription *entity = [NSEntityDescription entityForName:@"GBStatistic"
                                                           inManagedObjectContext:ctx];
                 GBStatistic *stat = [(GBStatistic*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:ctx];
                 stat.sites.siteID = siteID;
                 stat.persons.personID = personID;
                 stat.date = obj.date;
                 stat.rank = obj.rank;
                 [arr addObject:stat];
                 [[GBDataManager sharedManager] saveDailyStatBySiteID:siteID
                                                          andPersonID:personID
                                                              andDate:stat.date
                                                              andRank:stat.rank];
             }
             
             if (success) {
                 [[NSNotificationCenter defaultCenter]
                  postNotificationName:@"FetchedDaily"
                  object:self];
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:dbKey];
                 success(arr);
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

- (BOOL) isUserExistAndCheckLogin: (NSString*) login andPassword: (NSString*) password {
    
    GBUser* user = [[GBDataManager sharedManager] userFromDBWithLogin:login];
    
    if ([login isEqualToString:user.loginName] && [password isEqualToString:user.password]) {
        NSLog(@"login credentials accepted");
        return YES;
    } else {
        return NO;
    }
    
    return NO;
}

- (void) saveUserWithLogin: (NSString*) login andPassword: (NSString*) password {
    
    [[GBDataManager sharedManager] saveUserWithLogin:login andPassword:password];
}

- (void) saveUserLastDateWithLogin: (NSString*) login {
    
    [[GBDataManager sharedManager] saveUserLastDateVisitWithLogin:login];
}

- (NSString*) userLastVisitDate: (NSString*) login {
    
    NSDate* lastVisitDate = [[GBDataManager sharedManager] userLastVisitDateWithLogin:login];
    NSString* lastVisit = [self timeLeftSinceDate:lastVisitDate];
    
    return lastVisit;
}

- (void) setUserCurrentState: (NSString*) login {
    
    [[GBDataManager sharedManager] setUserCurrentState:login];
}

- (void) setAllUsersStatesToNO {
    
    [[GBDataManager sharedManager] setAllUsersStatesToNo];
}

- (GBUser*) currentUser {
    
    return [[GBDataManager sharedManager] currentUser];
}

- (NSString*) stringFromDate:(NSDate*) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter stringFromDate:date];
}

-(NSString*) timeLeftSinceDate: (NSDate *) dateT {
    
    if (!dateT) {
        return @"nil";
    } else {
        
        NSString* str;
        // The time interval
        NSTimeInterval theTimeInterval = [[NSDate date] timeIntervalSinceDate:dateT];
        // Get the system calendar
        NSCalendar *sysCalendar = [NSCalendar currentCalendar];
        // Create the NSDates
        NSDate *date1 = [[NSDate alloc] init];
        NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
        // Get conversion to months, days, hours, minutes
        NSCalendarUnit unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
        NSInteger months = breakdownInfo.month;
        NSInteger days = breakdownInfo.day;
        NSInteger hours = breakdownInfo.hour;
        NSInteger minutes = breakdownInfo.minute;
        
        if (months == 0) {
            if (days == 0) {
                if (hours == 0) {
                    if (minutes == 0) {
                        str = [NSString stringWithFormat:@"%li seconds", (long)[breakdownInfo second]];
                    } else {
                        str = [NSString stringWithFormat:@"%li min  %li seconds", (long)[breakdownInfo minute], (long)[breakdownInfo second]];
                    }
                } else {
                    str =
                    [NSString stringWithFormat:@"%li hours %li min %li seconds", (long)[breakdownInfo hour], (long)[breakdownInfo minute], (long)[breakdownInfo second]];
                }
            } else {
                str =
                [NSString stringWithFormat:@"%li days %li hours %li min %li seconds", (long)[breakdownInfo day], (long)[breakdownInfo hour], (long)[breakdownInfo minute], (long)[breakdownInfo second]];
            }
        } else {
            str =
            [NSString stringWithFormat:@"%li months %li days %li hours %li min %li seconds", (long)[breakdownInfo month], (long)[breakdownInfo day], (long)[breakdownInfo hour], (long)[breakdownInfo minute], (long)[breakdownInfo second]];
        }
        
        return str;
    }
    
    return nil;
}

@end
