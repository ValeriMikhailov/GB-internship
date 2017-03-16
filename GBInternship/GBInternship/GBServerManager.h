//
//  GBServerManager.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBServerManager : NSObject

+ (GBServerManager*) sharedManager;

// All sites
- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray*productsArray)) success
                                 onFailure: (void(^)(NSError* error)) failure;

// All persons
- (void) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray*productsArray)) success
                                   onFailure: (void(^)(NSError* error)) failure;

// Fetch by siteID
- (void) getArrayBySiteID: (NSInteger) siteID
                onSuccess: (void(^)(NSArray* productsArray)) success
                onFailure: (void(^)(NSError* error)) failure;

@end
