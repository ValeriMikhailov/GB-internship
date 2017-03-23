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

@property (assign, nonatomic) BOOL sitesDB;
@property (assign, nonatomic) BOOL personsDB;
@property (assign, nonatomic) BOOL statisticDB;

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
    
    if (!self.sitesDB) {
        
        if ([self connectedToInternet]) {
            // Get data from Server
            [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
                
                for (GBSiteAPI* obj in sitesArray) {
                    // Save data in DB
                    [[GBDataManager sharedManager] saveSiteWithID:obj.siteID andName:obj.siteURL];
                }
                
                if (success) {
                    self.sitesDB = YES;
                    success(sitesArray);
                }
            } onFailure:^(NSError *error) {
            }];
        } else {
            
            NSLog(@"Connect to Internet and complete DB!");
        }
    } else {
        
        // Get data from DB
        [[GBDataManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
            if (success) {
                success(sitesArray);
            }
        } onFailure:^(NSError *error) {
        }];
    }
    
}

// Get all persons with their ranks
- (void) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray* personsArray)) success
                                   onFailure: (void(^)(NSError* error)) failure {
    
    if (!self.personsDB) {
        if ([self connectedToInternet]) {
            // Get data from Server
            [[GBServerManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
                
                for (GBPerson* obj in personsArray) {
                    // Save data in DB
                    [[GBDataManager sharedManager] savePersonWithID:obj.personID andName:obj.personName];
                }
                
                if (success) {
                    self.personsDB = YES;
                    success(personsArray);
                }
            } onFailure:^(NSError *error) {
            }];
        } else {
            
            NSLog(@"Connect to Internet and complete DB!");
        }
    } else {
        
        // Get data from DB
        [[GBDataManager sharedManager] getArrayOfAvaliablePersosnsOnSuccess:^(NSArray *personsArray) {
            if (success) {
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
    
    NSArray* statistic = [NSArray array];
    
    if (![self connectedToInternet] || ![self shouldUpdateDataFromServer]) {
        
        // Get data from DB
    
        
    } else {
        
        // Get data from Server
        
        [[GBServerManager sharedManager] getArrayBySiteID:siteID
                                                onSuccess:^(NSArray *statisticArray) {

                                                
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

- (BOOL) isLaunchedFirst {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
}

@end
