//
//  GBSite+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 21.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBSite+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBSite (CoreDataProperties)

+ (NSFetchRequest<GBSite *> *)fetchRequest;

@property (nonatomic) int16_t siteID;
@property (nullable, nonatomic, copy) NSString *siteURL;
@property (nullable, nonatomic, retain) NSSet<GBStatistic *> *statistic;

@end

@interface GBSite (CoreDataGeneratedAccessors)

- (void)addStatisticObject:(GBStatistic *)value;
- (void)removeStatisticObject:(GBStatistic *)value;
- (void)addStatistic:(NSSet<GBStatistic *> *)values;
- (void)removeStatistic:(NSSet<GBStatistic *> *)values;

@end

NS_ASSUME_NONNULL_END
