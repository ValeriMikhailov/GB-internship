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

@property (strong, nonatomic) GBUser* currentUser;

@end

@implementation GBStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [[GBPersistentManager sharedManager] currentUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender {
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[GBPersistentManager sharedManager] saveUserLastDateWithLogin:self.currentUser.loginName];
    [self byeAlert];
}

- (void) byeAlert {
    UIAlertController* bye =
    [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Dear %@, already leaving?", self.currentUser.loginName]
                                        message:@"Hope to see you soon!"
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
