//
//  GBLoginViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBLoginViewController.h"
#import "GBStatisticsViewController.h"

@interface GBLoginViewController ()

@end

@implementation GBLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   //this is for textfield delegete to work (solving problem with keyboard blocking textfields)
    
    _usernameFld.delegate = self;
    _passwordFld.delegate = self;
    

    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

#pragma mark - Actions
- (IBAction)loginUser:(id)sender {
    
    NSUserDefaults* df = [NSUserDefaults standardUserDefaults];
    
    if ([self.usernameFld.text isEqualToString:[df objectForKey:@"username"]] && [self.passwordFld.text isEqualToString:[df objectForKey:@"password"]]) {
        NSLog(@"login credentials accepted");
        [self openStatisticsView];
        
        self.usernameFld.text = nil;
        self.passwordFld.text = nil;
        
    } else {
        
        NSLog(@"login credentials incorrect");
        UIAlertController* error = [UIAlertController alertControllerWithTitle:@"Oooops" message:@"Your username and password does not match" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                             
                                                         }];
        
        
        [error addAction:okAction];
        [self presentViewController:error animated:YES completion:nil];
    }
}


- (void) openStatisticsView {
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GBStatisticsViewController* vc = [sb instantiateViewControllerWithIdentifier:@"GBStatisticsNavigationController"];
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.usernameFld]) {
        [self.passwordFld becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

@end
