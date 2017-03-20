//
//  GBPages+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPages+CoreDataProperties.h"

@implementation GBPages (CoreDataProperties)

+ (NSFetchRequest<GBPages *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPages"];
}

@dynamic foundDate;
@dynamic lastScan;
@dynamic pageID;
@dynamic pageURL;
@dynamic siteID;
@dynamic statistic;

@end
