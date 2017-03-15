//
//  GBSites+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBSites+CoreDataProperties.h"

@implementation GBSites (CoreDataProperties)

+ (NSFetchRequest<GBSites *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBSites"];
}

@dynamic siteID;
@dynamic sitreURL;
@dynamic sitePages;

@end
