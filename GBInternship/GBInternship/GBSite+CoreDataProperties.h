//
//  GBSite+CoreDataProperties.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 19.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBSite+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBSite (CoreDataProperties)

+ (NSFetchRequest<GBSite *> *)fetchRequest;

@property (nonatomic) int16_t siteID;
@property (nullable, nonatomic, copy) NSString *siteURL;
@property (nullable, nonatomic, retain) NSSet<GBPage *> *pages;

@end

@interface GBSite (CoreDataGeneratedAccessors)

- (void)addPagesObject:(GBPage *)value;
- (void)removePagesObject:(GBPage *)value;
- (void)addPages:(NSSet<GBPage *> *)values;
- (void)removePages:(NSSet<GBPage *> *)values;

@end

NS_ASSUME_NONNULL_END
