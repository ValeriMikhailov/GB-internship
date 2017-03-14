//
//  GBSites+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 14.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBSites+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBSites (CoreDataProperties)

+ (NSFetchRequest<GBSites *> *)fetchRequest;

@property (nonatomic) int16_t siteID;
@property (nullable, nonatomic, copy) NSString *sitreURL;
@property (nullable, nonatomic, retain) NSSet<GBPages *> *pages;

@end

@interface GBSites (CoreDataGeneratedAccessors)

- (void)addPagesObject:(GBPages *)value;
- (void)removePagesObject:(GBPages *)value;
- (void)addPages:(NSSet<GBPages *> *)values;
- (void)removePages:(NSSet<GBPages *> *)values;

@end

NS_ASSUME_NONNULL_END
