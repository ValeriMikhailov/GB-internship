//
//  GBStatisticsViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatisticsViewController.h"

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
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GBStatisticsViewController* vc = [sb instantiateViewControllerWithIdentifier:@"GBLoginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
