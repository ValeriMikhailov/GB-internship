//
//  GBPerson+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 23.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPerson+CoreDataProperties.h"

@implementation GBPerson (CoreDataProperties)

+ (NSFetchRequest<GBPerson *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPerson"];
}

@dynamic personID;
@dynamic personName;
@dynamic statistic;

@end
