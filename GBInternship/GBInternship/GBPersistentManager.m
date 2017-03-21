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
#import "GBSitesCD+CoreDataClass.h"
#import "GBPersonCD+CoreDataProperties.h"
#import "GBStatistic+CoreDataClass.h"
#import "GBPerson.h"

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

- (NSArray*) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure {
    
    NSArray* sites = [NSArray array];
    
    if (![self connectedToInternet] || ![self shouldUpdateDataFromServer]) {
        
        // Get data from DB
        
        sites = [[GBDataManager sharedManager] allObjectsByEntityName:@"GBSitesCD"];
        
    } else {
        
        // Get data from Server
        
        [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
            
            [sites arrayByAddingObjectsFromArray:sitesArray];
            
            for (GBSitesCD* obj in sitesArray) {
                
                [[GBDataManager sharedManager] saveSiteWithID:obj.siteID andName:obj.siteURL];
                
            }
            
        } onFailure:^(NSError *error) {
            
            
        }];
        
    }
    
    return sites;
    
}

// Get all persons with their ranks
- (NSArray*) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray* personsArray)) success
                                       onFailure: (void(^)(NSError* error)) failure{
    
    NSArray* persons = [NSArray array];
    
    if (![self connectedToInternet] || ![self shouldUpdateDataFromServer]) {
        
        // Get data from DB
        
        persons = [[GBDataManager sharedManager] allObjectsByEntityName:@"GBPersonCD"];
        
    } else {
        
        // Get data from Server
        
        [[GBServerManager sharedManager]
         getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
            
            [persons arrayByAddingObjectsFromArray:personsArray];
            
            for (GBPersonCD* obj in personsArray) {
                
                [[GBDataManager sharedManager] savePersonWithID:obj.personID andName:obj.personName];
                
            }
            
        } onFailure:^(NSError *error) {
            
            
        }];
        
    }
    
    return persons;
}

// Get statistic by siteID
- (NSArray*) getStatisticBySiteID: (NSInteger) siteID
                        onSuccess: (void(^)(NSArray* statisticArray)) success
                        onFailure: (void(^)(NSError* error)) failure {
    
    NSArray* statistic = [NSArray array];
    
    if (![self connectedToInternet] || ![self shouldUpdateDataFromServer]) {
        
        // Get data from DB
        
        //statistic = [[GBDataManager sharedManager] allObjectsByEntityName:@"GBStatistic"];
        
    } else {
        
        // Get data from Server
        
        [[GBServerManager sharedManager] getArrayBySiteID:siteID
                                                onSuccess:^(NSArray *statisticArray) {

                                                
                                                } onFailure:^(NSError *error) {
                                                
                                                }];
        
    }
    
    return statistic;
    
}

#pragma nark - Helpful methods - 

- (BOOL) connectedToInternet {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSASCIIStringEncoding error:nil];
    
    return ( URLString != NULL ) ? YES : NO;
}

- (BOOL) shouldUpdateDataFromServer {
    
    return YES;
}

@end
