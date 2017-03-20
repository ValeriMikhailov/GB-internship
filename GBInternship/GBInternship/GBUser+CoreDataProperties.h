//
//  GBUser+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest;

@property (nonatomic) int16_t userID;
@property (nullable, nonatomic, copy) NSString *loginName;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSDate *lastVisitDate;

@end

NS_ASSUME_NONNULL_END
