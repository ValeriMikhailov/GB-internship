//
//  GBKeyWord+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBKeyWord+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBKeyWord (CoreDataProperties)

+ (NSFetchRequest<GBKeyWord *> *)fetchRequest;

@property (nonatomic) int16_t keyWordID;
@property (nullable, nonatomic, copy) NSString *keyWordName;
@property (nullable, nonatomic, retain) GBPersonCD *personID;

@end

NS_ASSUME_NONNULL_END
