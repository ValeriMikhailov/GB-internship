//
//  GBDailyStatisticsViewController.h
//  GBInternship
//
//  Created by Mac on 3/24/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "GBPersistentManager.h"
#import "GBDataManager.h"
#import "GBServerManager.h"
#import "GBPerson+CoreDataProperties.h"
#import "GBSite+CoreDataProperties.h"
#import "GBStatistic+CoreDataClass.h"

@interface GBDailyStatisticsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *personsArray;
@property (strong, nonatomic) NSArray *sitesArray;
@property (strong, nonatomic) NSArray *statisticArray;
@property (strong, nonatomic) NSArray *startDayArray;
@property (strong, nonatomic) NSArray *endDayArray;


@property (strong, nonatomic) GBPerson *pickedPerson;
@property (strong, nonatomic) GBSite *pickedSite;
@property (strong, nonatomic) NSDate *pickedStartDate;
@property (strong, nonatomic) NSDate *pickedEndDate;

@property (weak, nonatomic) IBOutlet UIButton *showStatisticsButtonOutlet;

- (IBAction)showStatisticsButtonAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *pickedSiteTextField;
@property (weak, nonatomic) IBOutlet UITextField *pickedPersonTextField;
@property (weak, nonatomic) IBOutlet UITextField *pickedStartDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *pickedEndDateTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *personPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *sitePicker;
@property (weak, nonatomic) IBOutlet UITableView *ranksTable;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@end
