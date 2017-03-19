//
//  GBRank+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBRank+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBRank (CoreDataProperties)

+ (NSFetchRequest<GBRank *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateScan;
@property (nonatomic) int16_t rankScore;
@property (nullable, nonatomic, retain) GBKeyWord *keyWord;
@property (nullable, nonatomic, retain) GBPage *page;

@end

NS_ASSUME_NONNULL_END
