//
//  GBKeyWords+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBKeyWords+CoreDataProperties.h"

@implementation GBKeyWords (CoreDataProperties)

+ (NSFetchRequest<GBKeyWords *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBKeyWords"];
}

@dynamic keyWordID;
@dynamic keyWord;
@dynamic person;
@dynamic statistic;

@end
