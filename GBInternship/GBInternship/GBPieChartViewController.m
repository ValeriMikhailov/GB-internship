//
//  GBPieChartViewController.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 08.04.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBPieChartViewController.h"
#import "Charts-Swift.h"

@interface GBPieChartViewController () <ChartViewDelegate>

@property (strong, nonatomic) IBOutlet PieChartView* chartView;

@end

@implementation GBPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Pie Chart";
    
    [self setupPieChartView:self.chartView];
    
    self.chartView.delegate = self;
    
    // entry label styling
    self.chartView.entryLabelColor = UIColor.whiteColor;
    self.chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    
    [self.chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    
    [self setDataCount:(int)self.persons.count range:100];
}

- (void)setupPieChartView:(PieChartView *)chartView {
    chartView.usePercentValuesEnabled = YES;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"Charts\nby GBInternship"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 15, 15)];
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = YES;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 5.0;
    l.yOffset = 70.0;
    
}

- (void)setDataCount:(int)count range:(double)range {
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.values[i] doubleValue] label:self.persons[i % self.persons.count]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:self.siteTitle];
    dataSet.sliceSpace = 2.0;

    // add a lot of colors
    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
//    [colors addObjectsFromArray:ChartColorTemplates.colorful];
//    [colors addObjectsFromArray:ChartColorTemplates.liberty];
//    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:76/255.f green:175/255.f blue:80/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:205/255.f green:220/255.f blue:57/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:200/255.f green:230/255.f blue:201/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:189/255.f green:189/255.f blue:189/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.blackColor];
    
    self.chartView.data = data;
    [self.chartView highlightValues:nil];
}

#pragma mark - ChartViewDelegate -

- (void)chartValueSelected:(ChartViewBase*)chartView
                     entry:(ChartDataEntry*)entry
                 highlight:(ChartHighlight*)highlight {
    
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase*)chartView {
    
    NSLog(@"chartValueNothingSelected");
}



@end
