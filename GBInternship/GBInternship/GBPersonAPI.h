//
//  GBPersonAPI.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 21.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBPersonAPI : NSObject

@property (assign, nonatomic) NSInteger personID;
@property (copy, nonatomic) NSString* personName;
@property (strong, nonatomic) NSMutableArray* statistic;


@end
