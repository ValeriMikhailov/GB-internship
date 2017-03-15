//
//  GBPerson+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPerson+CoreDataProperties.h"

@implementation GBPerson (CoreDataProperties)

+ (NSFetchRequest<GBPerson *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBPerson"];
}

@dynamic personFirstName;
@dynamic personID;
@dynamic personLastName;
@dynamic personKeyWord;

@end
