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
    
    // Important methods
    [[GBPersistentManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
        _personsArray=personsArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBPersistentManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        _sitesArray=sitesArray;
        for (GBSite* site in sitesArray) {
            [[GBPersistentManager sharedManager]
             getStatisticBySiteID:site.siteID
             onSuccess:^(NSArray *statisticArray) {
             } onFailure:^(NSError *error) {
                 
             }];
        }
    } onFailure:^(NSError *error) {
        
    }];

    
    return YES;
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
    [[GBPersistentManager sharedManager] setAllUsersStatesToNO];
}

@end
