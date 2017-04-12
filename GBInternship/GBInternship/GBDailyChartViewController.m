//
//  GBDailyChartViewController.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 12.04.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBDailyChartViewController.h"
#import "Charts-Swift.h"

@interface GBDailyChartViewController () <ChartViewDelegate, IChartAxisValueFormatter>

@property (strong, nonatomic) IBOutlet BarChartView* chartView;

@end

@implementation GBDailyChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Daily Bar Chart";    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    
    self.chartView.maxVisibleCount = 60;
    self.chartView.pinchZoomEnabled = YES;
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.drawBordersEnabled = YES;
    self.chartView.borderLineWidth = 1.0;
    [self.chartView animateWithXAxisDuration:1.5 yAxisDuration:1.5 easingOption:ChartEasingOptionLinear];
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.granularity = 1.0;
    xAxis.centerAxisLabelsEnabled = NO;
    xAxis.labelRotationAngle = 0;
    xAxis.valueFormatter = self;
    xAxis.drawGridLinesEnabled = NO;
    
    self.chartView.leftAxis.drawGridLinesEnabled = NO;
    self.chartView.rightAxis.drawGridLinesEnabled = NO;
    self.chartView.legend.enabled = NO;
    
    [self setDataCount:(int)self.dates.count range:100.0];
    
}

- (void)setDataCount:(int)count range:(double)range {
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        //NSLog(@"date %i is: %@", i, self.dates[i]);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[self.ranks[i] integerValue]]];
    }
    
    BarChartDataSet *set1 = nil;
    if (self.chartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)self.chartView.data.dataSets[0];
        set1.values = yVals;
        [self.chartView.data notifyDataChanged];
        [self.chartView notifyDataSetChanged];
    } else {
        
        // add a lot of colors
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObject:[UIColor colorWithRed:76/255.f green:175/255.f blue:80/255.f alpha:1.f]];
        [colors addObject:[UIColor colorWithRed:205/255.f green:220/255.f blue:57/255.f alpha:1.f]];
        [colors addObject:[UIColor colorWithRed:200/255.f green:230/255.f blue:201/255.f alpha:1.f]];
        [colors addObject:[UIColor colorWithRed:189/255.f green:189/255.f blue:189/255.f alpha:1.f]];
        
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
        set1.colors = colors;
        set1.drawValuesEnabled = YES;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        
        self.chartView.data = data;
        self.chartView.fitBars = YES;
    }
    
    [self.chartView setNeedsDisplay];
}

#pragma mark - Help methods -

- (NSString*) stringFromDate:(NSDate*) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd\nMMM/''yy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter stringFromDate:date];
}


#pragma mark - IAxisValueFormatter -

- (NSString*) stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
    NSInteger val = value;
    
    if (val >= 0 && val < self.dates.count) {
        return [self stringFromDate:self.dates[val]];
    }
    
    return nil;
}


@end
