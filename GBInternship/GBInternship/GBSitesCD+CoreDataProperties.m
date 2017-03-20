//
//  GBSitesCD+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBSitesCD+CoreDataProperties.h"

@implementation GBSitesCD (CoreDataProperties)

+ (NSFetchRequest<GBSitesCD *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBSitesCD"];
}

@dynamic siteID;
@dynamic siteURL;
@dynamic pages;

@end
