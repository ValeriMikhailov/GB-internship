//
//  GBPage+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPage (CoreDataProperties)

+ (NSFetchRequest<GBPage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *foundDate;
@property (nullable, nonatomic, copy) NSDate *lastScanDate;
@property (nonatomic) int16_t pageID;
@property (nullable, nonatomic, copy) NSString *pageURL;
@property (nullable, nonatomic, retain) NSSet<GBRank *> *rankPage;
@property (nullable, nonatomic, retain) GBSite *site;

@end

@interface GBPage (CoreDataGeneratedAccessors)

- (void)addRankPageObject:(GBRank *)value;
- (void)removeRankPageObject:(GBRank *)value;
- (void)addRankPage:(NSSet<GBRank *> *)values;
- (void)removeRankPage:(NSSet<GBRank *> *)values;

@end

NS_ASSUME_NONNULL_END
