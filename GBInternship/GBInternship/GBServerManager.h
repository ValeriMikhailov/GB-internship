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

- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray*productsArray)) success
                                 onFailure: (void(^)(NSError* error)) failure;
- (void) getArrayBySiteID: (NSInteger) category
                onSuccess: (void(^)(NSArray* productsArray)) success
                onFailure: (void(^)(NSError* error)) failure;

@end
