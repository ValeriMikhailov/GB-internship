//
//  GBUser+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest;

@property (nonatomic) int16_t userID;
@property (nullable, nonatomic, copy) NSString *userPassword;
@property (nonatomic) BOOL userIsAdmin;
@property (nullable, nonatomic, copy) NSDate *userLastVisitDate;
@property (nullable, nonatomic, copy) NSString *userLogin;

@end

NS_ASSUME_NONNULL_END
