//
//  GBStatistic+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatistic+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBStatistic (CoreDataProperties)

+ (NSFetchRequest<GBStatistic *> *)fetchRequest;

@property (nonatomic) int16_t rank;
@property (nullable, nonatomic, retain) GBPages *pageID;
@property (nullable, nonatomic, retain) GBPersonCD *personID;

@end

NS_ASSUME_NONNULL_END
