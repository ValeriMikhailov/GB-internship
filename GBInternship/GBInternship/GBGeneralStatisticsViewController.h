//
//  GBGeneralStatisticsViewController.h
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBPersistentManager.h"
#import "GBDataManager.h"
#import "GBServerManager.h"
#import "GBPerson+CoreDataProperties.h"
#import "GBSite+CoreDataProperties.h"
#import "GBStatistic+CoreDataClass.h"

@interface GBGeneralStatisticsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *personsArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (strong, nonatomic) NSArray *statisticArray;



@property (weak, nonatomic) IBOutlet UITextField *pickedSiteTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *personPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sitePicker;
@property (weak, nonatomic) IBOutlet UITableView *ranksTable;
@end
