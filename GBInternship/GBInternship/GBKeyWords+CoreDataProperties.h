//
//  GBKeyWords+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBKeyWords+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBKeyWords (CoreDataProperties)

+ (NSFetchRequest<GBKeyWords *> *)fetchRequest;

@property (nonatomic) int16_t keyWordID;
@property (nullable, nonatomic, copy) NSString *keyWord;
@property (nullable, nonatomic, retain) GBPerson *person;
@property (nullable, nonatomic, retain) NSSet<GBStatistics *> *statistic;

@end

@interface GBKeyWords (CoreDataGeneratedAccessors)

- (void)addStatisticObject:(GBStatistics *)value;
- (void)removeStatisticObject:(GBStatistics *)value;
- (void)addStatistic:(NSSet<GBStatistics *> *)values;
- (void)removeStatistic:(NSSet<GBStatistics *> *)values;

@end

NS_ASSUME_NONNULL_END
