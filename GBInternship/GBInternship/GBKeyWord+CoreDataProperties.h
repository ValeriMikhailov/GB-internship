//
//  GBKeyWord+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBKeyWord+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBKeyWord (CoreDataProperties)

+ (NSFetchRequest<GBKeyWord *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *keyWord;
@property (nonatomic) int16_t keyWordID;
@property (nullable, nonatomic, retain) GBPersonCD *person;
@property (nullable, nonatomic, retain) GBRank *rank;

@end

NS_ASSUME_NONNULL_END
