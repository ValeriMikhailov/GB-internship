//
//  AppDelegate.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "AppDelegate.h"
#import "GBPersistentManager.h"
#import "GBDataManager.h"
#import "GBServerManager.h"
#import "GBUser+CoreDataClass.h"
#import "GBPerson+CoreDataClass.h"
#import "GBStatistic+CoreDataClass.h"
#import "GBSite+CoreDataClass.h"
#import "GBPersonAPI.h"
#import "GBSiteAPI.h"
#import "GBStatisticAPI.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray* tmp;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    // Examples to check fetch data from each manager
    // GBServerManager
   
   /* [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        _sitesArray=sitesArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBServerManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
        _personsArray=personsArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    for(GBSite* obj in _sitesArray){
        
    
    [[GBServerManager sharedManager] getArrayBySiteID: obj.siteID
                                            onSuccess:^(NSArray *statisticArray) {
                                                for (GBPersonAPI* pers in statisticArray) {
                                                    NSArray* arr = [NSArray arrayWithArray:pers.statistic];
                                                    for (GBStatisticAPI* stat in arr) {
                                                        NSLog(@"Site: %ld, Rank: %ld, StartDate: %@", (long)stat.siteID, (long)stat.rank, [self stringFromDate:stat.startDate]);
                                                    }
                                                }
                                            } onFailure:^(NSError *error) {
                                                
                                            }];
        
    };
    
    */
    
    /*
    NSDate* date1 = [self dateFromString:@"2017-03-09"];
    NSDate* date2 = [self dateFromString:@"2017-03-15"];
    [[GBServerManager sharedManager] getArrayDailyBySiteID:1
                                               andPersonID:1
                                       andBetweenFirstDate:date1
                                                andEndDate:date2
                                                 onSuccess:^(NSArray *statisticArray) {
                                                     
                                                     for (GBStatisticAPI* stat in statisticArray) {
                                                         NSLog(@"Name: %ld, Site: %ld, Rank: %ld, StartDate: %@", (long)stat.personID, (long)stat.siteID, (long)stat.rank, [self stringFromDate:stat.date]);
                                                     }
                                                     
                                                 } onFailure:^(NSError *error) {
                                                     
                                                 }];
    */
    //GBDataManger
    
    
   /*
    [[GBDataManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        for (GBSite* site in sitesArray) {
            NSLog(@"site ID: %ld and siteURL: %@", (long)site.siteID, site.siteURL);
        }
        _sitesArray =sitesArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    for (GBSite* site in _sitesArray) {
        NSLog(@"loaded site ID: %ld and siteURL: %@", (long)site.siteID, site.siteURL);
    }
    
    [[GBDataManager sharedManager] getArrayOfAvaliablePersosnsOnSuccess:^(NSArray *personsArray) {
        for (GBPerson* pers in personsArray) {
            NSLog(@"pers ID: %ld and Name: %@", (long)pers.personID, pers.personName);
        }
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBDataManager sharedManager] getArrayBySiteID:1 onSuccess:^(NSArray *statisticArray) {
        for (GBStatistic* stat in statisticArray) {
            NSLog(@"Name: %@, Rank: %d, StartDate: %@", stat.persons.personName, stat.rank, [self stringFromDate:stat.startDate]);
        }
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBDataManager sharedManager] getArrayDailyBySiteID:1
                                             andPersonID:1
                                     andBetweenFirstDate:date1
                                              andEndDate:date2
                                               onSuccess:^(NSArray *statisticArray) {
                                                   
                                                   for (GBStatistic* stat in statisticArray) {
                                                       NSLog(@"Name: %@, Site: %@, Rank: %d, StartDate: %@", stat.persons.personName, stat.sites.siteURL, stat.rank, [self stringFromDate:stat.date]);
                                                   }
                                                   
                                               } onFailure:^(NSError *error) {
                                                   
                                               }];*/
    
    //GBPersistentManager
    
//    [[GBPersistentManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
//        for (GBSite* site in sitesArray) {
//            NSLog(@"site ID: %d and siteURL: %@", site.siteID, site.siteURL);
//        }
//    } onFailure:^(NSError *error) {
//        
//    }];
//    
//    [[GBPersistentManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
//        for (GBPerson* pers in personsArray) {
//            NSLog(@"pers ID: %d and Name: %@", pers.personID, pers.personName);
//        }
//    } onFailure:^(NSError *error) {
//        
//    }];
//    
//    [[GBPersistentManager sharedManager]
//     getStatisticBySiteID:1
//        onSuccess:^(NSArray *statisticArray) {
//            for (GBStatistic* stat in statisticArray) {
//                NSLog(@"Name: %@, Rank: %d, StartDate: %@", stat.persons.personName, stat.rank, [self stringFromDate:stat.startDate]);
//            }
//        } onFailure:^(NSError *error) {
//            
//        }];
//
//    //NSDate* date1 = [self dateFromString:@"2017-03-09"];
//    //NSDate* date2 = [self dateFromString:@"2017-03-15"];
//    [[GBPersistentManager sharedManager] getArrayDailyBySiteID:1
//                                                   andPersonID:1
//                                           andBetweenFirstDate:date1
//                                                    andEndDate:date2
//                                                     onSuccess:^(NSArray *statisticArray) {
//                                                         
//                                                         for (GBStatisticAPI* stat in statisticArray) {
//                                                             NSLog(@"Name: %ld, Site: %ld, Rank: %ld, StartDate: %@", (long)stat.personID, (long)stat.siteID, (long)stat.rank, [self stringFromDate:stat.date]);
//                                                         }
//                                                         
//                                                     } onFailure:^(NSError *error) {
//                                                         
//                                                     }];
    
    return YES;
}

- (NSDate*) dateFromString:(NSString*) string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter dateFromString:string];
}

- (NSString*) stringFromDate:(NSDate*) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter stringFromDate:date];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[GBDataManager sharedManager] saveContext];
}

@end
