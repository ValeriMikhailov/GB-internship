//
//  GBPieChartViewController.h
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 08.04.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBPieChartViewController : UIViewController

@property (strong, nonatomic) NSArray* persons;
@property (strong, nonatomic) NSArray* values;
@property (copy, nonatomic) NSString* siteTitle;

@end
