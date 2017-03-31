//
//  GBUser+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 31.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBUser (CoreDataProperties)

+ (NSFetchRequest<GBUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *lastVisitDate;
@property (nullable, nonatomic, copy) NSString *loginName;
@property (nonatomic) int16_t userID;
@property (nullable, nonatomic, copy) NSString *password;
@property (nonatomic) BOOL isCurrent;

@end

NS_ASSUME_NONNULL_END
