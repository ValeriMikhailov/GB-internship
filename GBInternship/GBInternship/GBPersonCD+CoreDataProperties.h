//
//  GBPersonCD+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPersonCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPersonCD (CoreDataProperties)

+ (NSFetchRequest<GBPersonCD *> *)fetchRequest;

@property (nonatomic) int16_t personID;
@property (nullable, nonatomic, copy) NSString *personName;
@property (nullable, nonatomic, retain) NSSet<GBKeyWord *> *keyWord;

@end

@interface GBPersonCD (CoreDataGeneratedAccessors)

- (void)addKeyWordObject:(GBKeyWord *)value;
- (void)removeKeyWordObject:(GBKeyWord *)value;
- (void)addKeyWord:(NSSet<GBKeyWord *> *)values;
- (void)removeKeyWord:(NSSet<GBKeyWord *> *)values;

@end

NS_ASSUME_NONNULL_END
