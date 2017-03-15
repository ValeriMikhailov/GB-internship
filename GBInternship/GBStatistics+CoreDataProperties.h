//
//  GBStatistics+CoreDataProperties.h
//  
//
//  Created by Stanly Shiyanovskiy on 15.03.17.
//
//  This file was automatically generated and should not be edited.
//

#import "GBStatistics+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GBStatistics (CoreDataProperties)

+ (NSFetchRequest<GBStatistics *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *statisticDateOfScan;
@property (nullable, nonatomic, copy) NSString *statisticKeyWord;
@property (nullable, nonatomic, copy) NSString *statisticPage;
@property (nullable, nonatomic, retain) GBKeyWords *keyWords;
@property (nullable, nonatomic, retain) GBPages *pages;

@end

NS_ASSUME_NONNULL_END
