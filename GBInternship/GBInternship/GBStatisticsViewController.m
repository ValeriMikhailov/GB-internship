//
//  GBStatisticsViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatisticsViewController.h"
#import "GBLoginViewController.h"

@interface GBStatisticsViewController ()

@end

@implementation GBStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender {

       
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
