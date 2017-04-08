//
//  GBGeneralStatisticsViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBGeneralStatisticsViewController.h"
#import "GBPieChartViewController.h"

@interface GBGeneralStatisticsViewController ()

- (IBAction)openCharts:(UIButton *)sender;

@end

@implementation GBGeneralStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadUI)
                                                 name:@"FetchedSites"
                                               object:nil];
    
    _sitePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    
    _sitePicker.delegate = self;
    _sitePicker.showsSelectionIndicator = YES;
    _sitePicker.dataSource=self;

    
     _pickedSiteTextField.inputView=[self createPicker];
    
    
    [[GBPersistentManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        _sitesArray =sitesArray;
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBPersistentManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
        _personsArray =personsArray;
    } onFailure:^(NSError *error) {
        
    }];
    
        

}


- (void) reloadUI {
    
    [self.ranksTable reloadData];
    [self.sitePicker reloadAllComponents];
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
    int count = (int)_sitesArray.count;
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    GBSite* site = (GBSite*) _sitesArray[row];
    NSString* stringInPicker = site.siteURL;
    return stringInPicker;
}



#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    GBSite* site = (GBSite*) _sitesArray[row];
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"%@",
                              site.siteURL];
    
    _pickedSiteTextField.text = resultString;
    [_pickedSiteTextField resignFirstResponder];
    
 
    [[GBPersistentManager sharedManager]
     getStatisticBySiteID:site.siteID
     onSuccess:^(NSArray *statisticArray) {
         _statisticArray=statisticArray;
     } onFailure:^(NSError *error) {
    }];
    
     [_ranksTable reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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
    
    
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@",statistic.persons.personName];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%hd",statistic.rank];
    cell.detailTextLabel.textAlignment=NSTextAlignmentRight;
    // Configure the cell...
    
    
    return cell;
}





// popover with picker for sites

- (UIView *)createPicker {
    
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    
    pickerView.backgroundColor = [UIColor whiteColor];
    //UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, 300, 120)];
    
    [pickerView addSubview: _sitePicker];
    _sitePicker.center = CGPointMake(pickerView.frame.size.width  / 2,
                                     pickerView.frame.size.height / 2);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1]];
    [titleLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 16.0f]];
    titleLabel.text=@"Choose Site";
    titleLabel.textAlignment= NSTextAlignmentCenter;
    [pickerView addSubview:titleLabel];
    
    return pickerView;
}

#pragma mark - Actions -

//- (IBAction)openCharts:(UIButton *)sender {
//    
//    GBPieChartViewController* vc = [[GBPieChartViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFormSheet;
//    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [V1 presentViewController:V2 animated:YES completion:nil];
//    V2.view.superview.frame = CGRectMake(0, 0, 540, 620); //it's important to do this after presentModalViewController
//    V2.view.superview.center = V1.view.center;
//    [V1 release];
//}
@end
