//
//  GBStatistic+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 22.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatistic+CoreDataProperties.h"

@implementation GBStatistic (CoreDataProperties)

+ (NSFetchRequest<GBStatistic *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBStatistic"];
}

@dynamic date;
@dynamic rank;
@dynamic startDate;
@dynamic persons;
@dynamic sites;

@end
