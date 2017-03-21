//
//  GBPersistentManager.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBPersistentManager : NSObject

+ (GBPersistentManager*) sharedManager;

// Get all avaliable sites
- (NSArray*) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure;

// Get all persons with their ranks


// Get site by siteID


// Get daily statistic by siteID, personID and date

@end
