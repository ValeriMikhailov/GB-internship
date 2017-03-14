//
//  GBPages+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPages (CoreDataProperties)

+ (NSFetchRequest<GBPages *> *)fetchRequest;

@property (nonatomic) int16_t pageID;
@property (nullable, nonatomic, copy) NSString *pageURL;
@property (nullable, nonatomic, copy) NSDate *pageDateOfFirstScan;
@property (nullable, nonatomic, copy) NSDate *pageDateOfLastScan;
@property (nullable, nonatomic, retain) NSSet<GBStatistics *> *statistics;
@property (nullable, nonatomic, retain) GBSites *sites;

@end

@interface GBPages (CoreDataGeneratedAccessors)

- (void)addStatisticsObject:(GBStatistics *)value;
- (void)removeStatisticsObject:(GBStatistics *)value;
- (void)addStatistics:(NSSet<GBStatistics *> *)values;
- (void)removeStatistics:(NSSet<GBStatistics *> *)values;

@end

NS_ASSUME_NONNULL_END
