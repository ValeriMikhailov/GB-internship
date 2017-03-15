//
//  GBSites+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBSites+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBSites (CoreDataProperties)

+ (NSFetchRequest<GBSites *> *)fetchRequest;

@property (nonatomic) int16_t siteID;
@property (nullable, nonatomic, copy) NSString *sitreURL;
@property (nullable, nonatomic, retain) NSSet<GBPages *> *sitePages;

@end

@interface GBSites (CoreDataGeneratedAccessors)

- (void)addSitePagesObject:(GBPages *)value;
- (void)removeSitePagesObject:(GBPages *)value;
- (void)addSitePages:(NSSet<GBPages *> *)values;
- (void)removeSitePages:(NSSet<GBPages *> *)values;

@end

NS_ASSUME_NONNULL_END
