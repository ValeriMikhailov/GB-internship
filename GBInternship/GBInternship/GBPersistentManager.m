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

#pragma nark - Helpful methods - 

- (BOOL) connectedToInternet {
    
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSASCIIStringEncoding error:nil];
    
    return ( URLString != NULL ) ? YES : NO;
}

- (BOOL) shouldUpdateDataFromServer {
    
    return YES;
}

@end
