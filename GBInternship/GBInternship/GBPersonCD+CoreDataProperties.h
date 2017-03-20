//
//  GBPersonCD+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPersonCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPersonCD (CoreDataProperties)

+ (NSFetchRequest<GBPersonCD *> *)fetchRequest;

@property (nonatomic) int16_t personID;
@property (nullable, nonatomic, copy) NSString *personName;
@property (nullable, nonatomic, retain) NSSet<GBKeyWord *> *keyWords;
@property (nullable, nonatomic, retain) NSSet<GBStatistic *> *statistic;

@end

@interface GBPersonCD (CoreDataGeneratedAccessors)

- (void)addKeyWordsObject:(GBKeyWord *)value;
- (void)removeKeyWordsObject:(GBKeyWord *)value;
- (void)addKeyWords:(NSSet<GBKeyWord *> *)values;
- (void)removeKeyWords:(NSSet<GBKeyWord *> *)values;

- (void)addStatisticObject:(GBStatistic *)value;
- (void)removeStatisticObject:(GBStatistic *)value;
- (void)addStatistic:(NSSet<GBStatistic *> *)values;
- (void)removeStatistic:(NSSet<GBStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
