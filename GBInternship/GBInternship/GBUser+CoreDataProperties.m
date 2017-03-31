//
//  GBUser+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 31.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBUser+CoreDataProperties.h"

@implementation GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBUser"];
}

@dynamic lastVisitDate;
@dynamic loginName;
@dynamic userID;
@dynamic password;

@end
