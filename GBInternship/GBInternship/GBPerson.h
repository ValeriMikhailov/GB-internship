//
//  GBPerson.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 16.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBPerson : NSObject

@property (assign, nonatomic) NSUInteger personID;
@property (copy, nonatomic) NSString* personName;
@property (assign, nonatomic) NSUInteger personRank;


@end
