//
//  GBUser+CoreDataProperties.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBUser+CoreDataProperties.h"

@implementation GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBUser"];
}

@dynamic userID;
@dynamic loginName;
@dynamic password;
@dynamic lastVisitDate;

@end
