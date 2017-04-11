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
@property (strong, nonatomic) IBOutlet UIView* popUp;
@property (strong, nonatomic) IBOutlet UIView* v1;
@property (strong, nonatomic) UIVisualEffectView* visualEffectView;
@property (weak, nonatomic) IBOutlet UIImageView* popupImg;
@property (weak, nonatomic) IBOutlet UITextView* popupTxt;
@property (weak, nonatomic) IBOutlet UILabel *popupLabel;

@end

@implementation GBPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Pie Chart";
    self.popUp.layer.cornerRadius = 25;
    self.popUp.layer.masksToBounds = YES;
    self.popUp.alpha = 0.8;
    self.popUp.center = CGPointMake(self.view.center.x, self.view.frame.origin.y + 300);
    [self addBlurView];
    
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
    [self animateIn];
    
    if ([[entry valueForKey:@"label"] isEqual:@"Путин"]) {
        self.popupImg.image = [UIImage imageNamed:@"Putin.jpg"];
        self.popupLabel.text = [NSString stringWithFormat:@"\tВлади́мир Влади́мирович Пу́тин (род. 7 октября 1952, Ленинград, РСФСР, СССР) — советский и российский государственный и политический деятель, действующий президент Российской Федерации с 7 мая 2012 года. С 2000 по 2008 год — второй президент Российской Федерации. В 1999—2000 годах и с 2008 по 2012 годы — председатель Правительства Российской Федерации. Занимал посты директора Федеральной службы безопасности Российской Федерации с 1998 по 1999 год, секретаря Совета безопасности Российской Федерации в 1999 году.\n\tВыпускник юридического факультета Ленинградского государственного университета. С 1977 года работал по линии контрразведки в следственном отделе Ленинградского управления КГБ. С 1985 по 1990 год служил в резидентуре советской внешней разведки в ГДР, работал в Дрездене под прикрытием в должности директора дрезденского Дома дружбы СССР—ГДР. 20 августа 1991 года в звании подполковника уволился из КГБ СССР. В 1991—1996 годах работал помощником ректора ЛГУ по международным вопросам, возглавлял Комитет по внешним связям мэрии Ленинграда, был советником мэра, первым заместителем председателя правительства Санкт-Петербурга. С августа 1996 года начал работать в Москве в должности заместителя управляющего делами Президента Российской Федерации. После недолгого пребывания во главе ФСБ России и на посту секретаря Совета безопасности Российской Федерации в августе 1999 года был назначен председателем Правительства Российской Федерации.\n\tПервым лицом государства стал 31 декабря 1999 года, когда по решению президента Российской Федерации Бориса Ельцина был назначен исполняющим обязанности президента Российской Федерации — в связи с уходом первого президента России в досрочную отставку. Впервые избран президентом Российской Федерации 26 марта 2000 года. Переизбирался на пост главы государства в 2004 и 2012 годах.\n\tПолковник запаса (1999). Действительный государственный советник Российской Федерации 1 класса (1997). Кандидат экономических наук (1997). Мастер спорта по дзюдо и самбо, чемпион Ленинграда по дзюдо (1976), заслуженный тренер России по самбо (1998). Свободно владеет немецким и английским языками."];
        
    } else if ([[entry valueForKey:@"label"] isEqual:@"Медведев"]) {
        self.popupImg.image = [UIImage imageNamed:@"Medvedev.jpg"];
        self.popupLabel.text = [NSString stringWithFormat:@"\tДми́трий Анато́льевич Медве́дев (род. 14 сентября 1965 года, Ленинград, РСФСР, СССР) — российский государственный и политический деятель, третий президент Российской Федерации (2008—2012), десятый председатель Правительства Российской Федерации (с 8 мая 2012 года), председатель партии «Единая Россия» (с 26 мая 2012 года). \n\tВ 2000—2001, 2002—2008 гг. — председатель совета директоров ОАО «Газпром». \n\tC 14 ноября 2005 года по 7 мая 2008 года — первый заместитель председателя Правительства Российской Федерации, куратор приоритетных национальных проектов."];
        
    } else if ([[entry valueForKey:@"label"] isEqual:@"Жириновский"]) {
        self.popupImg.image = [UIImage imageNamed:@"Zhirinovskiy.jpg"];
        self.popupLabel.text = [NSString stringWithFormat:@"\tВлади́мир Во́льфович Жирино́вский (до 10 июня 1964 года — Эйдельште́йн; род. 25 апреля 1946, Алма-Ата, Казахская ССР, СССР) — советский и российский политический деятель, заместитель Председателя Государственной Думы Федерального Собрания РФ (2000—2011), основатель и председатель партии ЛДПР, член Парламентской ассамблеи Совета Европы (ПАСЕ). Пять раз участвовал в выборах президента России (1991 (7,81 %%), 1996 (5,78 %%), 2000 (2,7 %%), 2008 (9,35 %%), 2012 (6,22 %%))."];
    }

}

- (void)chartValueNothingSelected:(ChartViewBase*)chartView {
    
    NSLog(@"chartValueNothingSelected");
    [self animateOut];
    
}

#pragma mark - Animnations - 
- (void) addBlurView {
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.frame = self.view.bounds;
    self.visualEffectView.alpha = 0.0;
    [self.view addSubview:self.visualEffectView];
    
}
- (void) animateIn {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (!self.v1) {
            self.v1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
            self.v1.backgroundColor = [UIColor blackColor];
            self.v1.alpha = 0.5;
            [self.view addSubview:self.v1];
        }
        
        self.visualEffectView.alpha = 0.8;
        self.popUp.center = self.view.center;
        [self.view addSubview:self.popUp];
    }];
}

- (void) animateOut {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popUp.center = CGPointMake(self.view.center.x, self.view.frame.origin.y + 1000);
        self.visualEffectView.alpha = 0.0;
        [self.v1 removeFromSuperview];
        self.v1 = nil;
        
    }];
}




@end
