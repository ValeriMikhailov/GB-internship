//
//  GBPage+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPage+CoreDataProperties.h"

@implementation GBPage (CoreDataProperties)

+ (NSFetchRequest<GBPage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPage"];
}

@dynamic foundDate;
@dynamic lastScanDate;
@dynamic pageID;
@dynamic pageURL;
@dynamic rankPage;
@dynamic site;

@end
