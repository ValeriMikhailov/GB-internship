//
//  GBStatistic+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 22.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatistic+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBStatistic (CoreDataProperties)

+ (NSFetchRequest<GBStatistic *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) int16_t rank;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, retain) NSSet<GBPerson *> *persons;
@property (nullable, nonatomic, retain) NSSet<GBSite *> *sites;

@end

@interface GBStatistic (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(GBPerson *)value;
- (void)removePersonsObject:(GBPerson *)value;
- (void)addPersons:(NSSet<GBPerson *> *)values;
- (void)removePersons:(NSSet<GBPerson *> *)values;

- (void)addSitesObject:(GBSite *)value;
- (void)removeSitesObject:(GBSite *)value;
- (void)addSites:(NSSet<GBSite *> *)values;
- (void)removeSites:(NSSet<GBSite *> *)values;

@end

NS_ASSUME_NONNULL_END
