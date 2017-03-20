//
//  GBSitesCD+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 20.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBSitesCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBSitesCD (CoreDataProperties)

+ (NSFetchRequest<GBSitesCD *> *)fetchRequest;

@property (nonatomic) int16_t siteID;
@property (nullable, nonatomic, copy) NSString *siteURL;
@property (nullable, nonatomic, retain) NSSet<GBPages *> *pages;

@end

@interface GBSitesCD (CoreDataGeneratedAccessors)

- (void)addPagesObject:(GBPages *)value;
- (void)removePagesObject:(GBPages *)value;
- (void)addPages:(NSSet<GBPages *> *)values;
- (void)removePages:(NSSet<GBPages *> *)values;

@end

NS_ASSUME_NONNULL_END
