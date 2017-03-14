//
//  GBPages+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPages+CoreDataProperties.h"

@implementation GBPages (CoreDataProperties)

+ (NSFetchRequest<GBPages *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPages"];
}

@dynamic pageID;
@dynamic pageURL;
@dynamic pageDateOfFirstScan;
@dynamic pageDateOfLastScan;
@dynamic statistics;
@dynamic sites;

@end
