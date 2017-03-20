//
//  GBPages+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPages (CoreDataProperties)

+ (NSFetchRequest<GBPages *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *foundDate;
@property (nullable, nonatomic, copy) NSDate *lastScan;
@property (nonatomic) int16_t pageID;
@property (nullable, nonatomic, copy) NSString *pageURL;
@property (nullable, nonatomic, retain) GBSitesCD *siteID;
@property (nullable, nonatomic, retain) GBStatistic *statistic;

@end

NS_ASSUME_NONNULL_END
