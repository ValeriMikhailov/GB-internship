//
//  GBPages+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPages (CoreDataProperties)

+ (NSFetchRequest<GBPages *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *pageDateOfFirstScan;
@property (nullable, nonatomic, copy) NSDate *pageDateOfLastScan;
@property (nonatomic) int16_t pageID;
@property (nullable, nonatomic, copy) NSString *pageURL;
@property (nullable, nonatomic, retain) GBSites *sites;
@property (nullable, nonatomic, retain) NSSet<GBStatistics *> *statistics;

@end

@interface GBPages (CoreDataGeneratedAccessors)

- (void)addStatisticsObject:(GBStatistics *)value;
- (void)removeStatisticsObject:(GBStatistics *)value;
- (void)addStatistics:(NSSet<GBStatistics *> *)values;
- (void)removeStatistics:(NSSet<GBStatistics *> *)values;

@end

NS_ASSUME_NONNULL_END
