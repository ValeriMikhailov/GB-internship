//
//  GBDailyStatisticsViewController.m
//  GBInternship
//
//  Created by Mac on 3/24/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBDailyStatisticsViewController.h"

@interface GBDailyStatisticsViewController ()
#define sitePicker 0
#define personPicker 1
#define startDayPicker 2
#define endDayPicker 3
@end

@implementation GBDailyStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadUI)
                                                 name:@"FetchedDaily"
                                               object:nil];
    
    [[GBPersistentManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        _sitesArray =sitesArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBPersistentManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
        _personsArray =personsArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    _pickedPersonTextField.inputView=[self createViewForPicker:_personPicker];
    _pickedSiteTextField.inputView=[self createViewForPicker:_sitePicker];
    
    _pickedStartDateTextField.inputView=[self createViewForDatePicker:_startDatePicker];
    _pickedEndDateTextField.inputView=[self createViewForDatePicker:_endDatePicker];
    [_startDatePicker addTarget:self action:@selector(selectStartDate) forControlEvents:UIControlEventValueChanged];
    [_endDatePicker addTarget:self action:@selector(selectEndDate) forControlEvents:UIControlEventValueChanged];
 
}


- (void) reloadUI {
    
    [self.ranksTable reloadData];
    [_sitePicker reloadAllComponents];
    [_personPicker reloadAllComponents];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    int count;
    if(pickerView.tag == sitePicker)
    {
        count = (int)_sitesArray.count;
        
    }
    else if (pickerView.tag == personPicker)
    {
        count = (int)_personsArray.count;
    }
   
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSString* stringInPicker;
    
    if(pickerView.tag == sitePicker) {
        GBSite* site = (GBSite*) _sitesArray[row];
        
        stringInPicker = site.siteURL;
        
    } else if (pickerView.tag == personPicker) {
        GBPerson* person = (GBPerson*) _personsArray[row];
        
        stringInPicker =person.personName;
    }
    
    return stringInPicker;
}



#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    if(pickerView.tag == sitePicker){
        
        GBSite* site = (GBSite*) _sitesArray[row];
        NSString *resultString = [[NSString alloc] initWithFormat:
                                  @"%@",
                                  site.siteURL];
        
        _pickedSiteTextField.text = resultString;
        [_pickedSiteTextField resignFirstResponder];
        
        _pickedSite=site;
        }
    
   else if(pickerView.tag == personPicker)
    {
        GBPerson* person = (GBPerson*) _personsArray[row];
        NSString *resultString = [[NSString alloc] initWithFormat:
                                  @"%@",
                                  person.personName];
        _pickedPersonTextField.text = resultString;
        [_pickedPersonTextField resignFirstResponder];
        _pickedPerson=person;
        
    }
    
}


- (IBAction)showStatisticsButtonAction:(id)sender {
    NSLog(@"******************");
    
    //NSDate* date1 = [self dateFromString:@"2017-03-09"];
    //NSDate* date2 = [self dateFromString:@"2017-03-15"];
    NSDate* date1 = _pickedStartDate;
    NSDate* date2 = _pickedEndDate;
    [[GBPersistentManager sharedManager] getArrayDailyBySiteID:_pickedSite.siteID
                                                   andPersonID:_pickedPerson.personID
                                           andBetweenFirstDate:date1
                                                    andEndDate:date2
                                                     onSuccess:^(NSArray *statisticArray) {
                                                   
                                                   for (GBStatistic* stat in statisticArray) {
                                                       NSLog(@"Name: %@, SiteID: %d, Rank: %d, StartDate: %@", stat.persons.personName, stat.sites.siteID, stat.rank, [self stringFromDate:stat.date]);
                                                       
                                                   }
                                                         self.statisticArray = statisticArray;
                                                         [self.ranksTable reloadData];
                                               } onFailure:^(NSError *error) {
                                                   
                                               }];
    
};



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"********%lu********",(unsigned long)_statisticArray.count);

    return _statisticArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:CellIdentifier];
    }
    
    GBStatistic* statistic = (GBStatistic*) _statisticArray[indexPath.row];
    
    //cell.textLabel.text = [[NSString alloc] initWithFormat:@"%u",statistic.rank];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@",[self stringFromDate:statistic.date]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%hd",statistic.rank];
    cell.detailTextLabel.textAlignment=NSTextAlignmentRight;
    // Configure the cell...
    
    
    return cell;
}


// popover with picker for sites

- (UIView *)createViewForPicker:(UIPickerView*) selectedPicker {
    
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    NSString* title;
    
    if(selectedPicker.tag == sitePicker)
    {
        title=@"Choose Site";
    }
    else if (selectedPicker.tag == personPicker)
    {
        title=@"Choose Person";
    }
    
    [pickerView addSubview: selectedPicker];
    
    selectedPicker.center = CGPointMake(pickerView.frame.size.width  / 2,
                                     pickerView.frame.size.height / 2);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1]];
    [titleLabel setFont:[UIFont fontWithName: @"Magistral" size: 16.0f]];
    titleLabel.text=title;
    titleLabel.textAlignment= NSTextAlignmentCenter;
    [pickerView addSubview:titleLabel];
    
    return pickerView;
}

-(void) selectStartDate
{
    _pickedStartDateTextField.text=[self stringFromDate:_startDatePicker.date];
    [_pickedStartDateTextField resignFirstResponder];
    _pickedStartDate=_startDatePicker.date;
}
-(void) selectEndDate
{
    _pickedEndDateTextField.text=[self stringFromDate:_endDatePicker.date];
    [_pickedEndDateTextField resignFirstResponder];
    _pickedEndDate=_endDatePicker.date;
}

- (UIView *)createViewForDatePicker:(UIDatePicker*) selectedPicker {
    
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    NSString* title;
    
    if(selectedPicker.tag == startDayPicker)
    {
        title=@"Choose Start Date";
    }
    else if (selectedPicker.tag == endDayPicker)
    {
        title=@"Choose End Date";
    }
    
    [pickerView addSubview: selectedPicker];
    
    selectedPicker.center = CGPointMake(pickerView.frame.size.width  / 2,
                                        pickerView.frame.size.height / 2);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1]];
    [titleLabel setFont:[UIFont fontWithName: @"Magistral" size: 16.0f]];
    titleLabel.text=title;
    titleLabel.textAlignment= NSTextAlignmentCenter;
    [pickerView addSubview:titleLabel];
    
    return pickerView;
}



- (NSDate*) dateFromString:(NSString*) string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter dateFromString:string];
}

- (NSString*) stringFromDate:(NSDate*) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter stringFromDate:date];
}


@end
