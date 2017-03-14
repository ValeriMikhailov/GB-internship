//
//  GBUser+CoreDataProperties.m
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBUser+CoreDataProperties.h"

@implementation GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GBUser"];
}

@dynamic userID;
@dynamic userPassword;
@dynamic userIsAdmin;
@dynamic userLastVisitDate;
@dynamic userLogin;

@end
