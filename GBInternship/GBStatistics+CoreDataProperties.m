//
//  GBStatistics+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBStatistics+CoreDataProperties.h"

@implementation GBStatistics (CoreDataProperties)

+ (NSFetchRequest<GBStatistics *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBStatistics"];
}

@dynamic statisticDateOfScan;
@dynamic statisticKeyWord;
@dynamic statisticPage;
@dynamic keyWords;
@dynamic pages;

@end
