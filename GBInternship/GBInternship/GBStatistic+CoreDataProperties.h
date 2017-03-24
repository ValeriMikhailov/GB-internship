//
//  GBStatistic+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 23.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatistic+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBStatistic (CoreDataProperties)

+ (NSFetchRequest<GBStatistic *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) int16_t rank;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, retain) GBPerson *persons;
@property (nullable, nonatomic, retain) GBSite *sites;

@end

@interface GBStatistic (CoreDataGeneratedAccessors)

- (void)bindServerModel:(id)model;
- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
