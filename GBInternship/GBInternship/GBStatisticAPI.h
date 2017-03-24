//
//  GBStatisticAPI.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 21.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBStatisticAPI : NSObject

@property (assign, nonatomic) NSInteger rank;
@property (copy, nonatomic) NSDate* startDate;
@property (copy, nonatomic) NSDate* date;
@property (copy, nonatomic) NSString* personName;
@property (assign, nonatomic) NSInteger personID;
@property (assign, nonatomic) NSInteger siteID;
@property (strong, nonatomic) NSMutableArray* persons;

@end
