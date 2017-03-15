//
//  GBPerson+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBPerson+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBPerson (CoreDataProperties)

+ (NSFetchRequest<GBPerson *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *personFirstName;
@property (nonatomic) int16_t personID;
@property (nullable, nonatomic, copy) NSString *personLastName;
@property (nullable, nonatomic, retain) NSSet<GBKeyWords *> *personKeyWord;

@end

@interface GBPerson (CoreDataGeneratedAccessors)

- (void)addPersonKeyWordObject:(GBKeyWords *)value;
- (void)removePersonKeyWordObject:(GBKeyWords *)value;
- (void)addPersonKeyWord:(NSSet<GBKeyWords *> *)values;
- (void)removePersonKeyWord:(NSSet<GBKeyWords *> *)values;

@end

NS_ASSUME_NONNULL_END
