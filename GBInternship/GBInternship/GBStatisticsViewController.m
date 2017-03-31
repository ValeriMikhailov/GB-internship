//
//  GBStatisticsViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBStatisticsViewController.h"
#import "GBLoginViewController.h"
#import "GBPersistentManager.h"

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
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [self byeAlert];
}

- (void) byeAlert {
    UIAlertController* bye =
    [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"See you later, dear %@", [[GBPersistentManager sharedManager] currentUser]]
                                        message:@"Will wait you again!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:bye animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bye dismissViewControllerAnimated:YES completion:^{
            [[GBPersistentManager sharedManager] setAllUsersStatesToNO];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    });
}
@end
