//
//  GBRank+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBRank+CoreDataProperties.h"

@implementation GBRank (CoreDataProperties)

+ (NSFetchRequest<GBRank *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBRank"];
}

@dynamic dateScan;
@dynamic rankScore;
@dynamic keyWord;
@dynamic page;

@end
