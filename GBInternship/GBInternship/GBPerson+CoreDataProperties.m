//
//  GBPerson+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPerson+CoreDataProperties.h"

@implementation GBPerson (CoreDataProperties)

+ (NSFetchRequest<GBPerson *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPerson"];
}

@dynamic personID;
@dynamic personFirstName;
@dynamic personLastName;
@dynamic personKeyWord;

@end
