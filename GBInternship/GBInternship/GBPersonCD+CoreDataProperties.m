//
//  GBPersonCD+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPersonCD+CoreDataProperties.h"

@implementation GBPersonCD (CoreDataProperties)

+ (NSFetchRequest<GBPersonCD *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPersonCD"];
}

@dynamic personID;
@dynamic personName;
@dynamic keyWords;
@dynamic statistic;

@end
