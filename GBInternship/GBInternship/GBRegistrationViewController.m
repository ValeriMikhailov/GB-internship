//
//  GBRegistrationViewController.m
//  GBInternship
//
//  Created by Mac on 3/23/17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBRegistrationViewController.h"
#import "GBLoginViewController.h"
#import "GBStatisticsViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface GBRegistrationViewController ()  <UITextFieldDelegate>

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;

@end

@implementation GBRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _usernameFld.delegate = self;
    _passwordFld.delegate = self;
    _reEnterPasswordFld.delegate =self;
}

//Register user
- (IBAction)registerUser:(id)sender {
    
    //Check for full fields and show alert
    if ([self.usernameFld.text isEqualToString:@""] || [self.passwordFld.text isEqualToString:@""]) {
        
        // empty fields alert
        [self emptyFieldsAlert];
        
    } else {
        
        //Check password and re-Enter password fields
        [self checkPasswordsMatch];
    }
}


- (void) checkPasswordsMatch {
    
    if ([self.passwordFld.text isEqualToString:self.reEnterPasswordFld.text]) {
        NSLog(@"passwords match!");
        [self registerNewUser:self.usernameFld.text andPassword:self.passwordFld.text];
        
    } else {
        //doesn't match passwords
        [self doesntMatchPasswordsAlert];
    }
}


- (void) registerNewUser:(NSString*)login andPassword:(NSString*)password {
    
    AFHTTPSessionManager* man = [AFHTTPSessionManager manager];
    man.requestSerializer = [AFHTTPRequestSerializer serializer];
    man.responseSerializer = [AFHTTPResponseSerializer serializer];
    man.securityPolicy.allowInvalidCertificates = YES;
    man.securityPolicy.validatesDomainName = NO;

    [man.requestSerializer setValue:@"application/x-www-form-urlencoded; application/json; charset=UTF-8; text/html" forHTTPHeaderField:@"Content-Type"];
    NSDictionary* params = @{@"userName": login,
                             @"password": password};
    
    [man GET:@"https://52.89.213.205:8443/rest/user/sites"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask* task, id responseObject) {

                         
                         NSLog(@"*************************");
                     } failure:^(NSURLSessionDataTask* task, NSError* error) {
                         
                     }];
    
    [man POST:@"https://52.89.213.205:8443/rest/user/signup"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionDataTask* task, id responseObject) {
                          
                          NSLog(@"*************************");
                          
                      } failure:^(NSURLSessionDataTask* task, NSError* error) {
                          NSLog(@"%@", error);
                          NSDictionary* dict = [error userInfo];
                          NSString* errorStr = [dict objectForKey:@"NSLocalizedDescription"];
                          
                          if ([errorStr isEqualToString:@"Request failed: unauthorized (401)"]){
                              
                          }
                      }];

    
    //successfully registered user alert
    //[self successfullyRegisteredAlert];
    
}


- (void) openStatisticsView {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GBStatisticsViewController* vc = [sb instantiateViewControllerWithIdentifier:@"GBStatisticsNavigationController"];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
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

#pragma mark - Help methods -
- (void) emptyFieldsAlert {
    
    UIAlertController* error =
    [UIAlertController alertControllerWithTitle:@"Oooops"
                                        message:@"You must complete all fields"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [error addAction:okAction];
    [self presentViewController:error animated:YES completion:nil];
}

- (void) doesntMatchPasswordsAlert {
    NSLog(@"passwords don't match");
    UIAlertController* error =
    [UIAlertController alertControllerWithTitle:@"Oooops"
                                        message:@"Your entered passwords do not match"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [error addAction:okAction];
    [self presentViewController:error animated:YES completion:nil];
}

- (void) successfullyRegisteredAlert {
    
    UIAlertController* success =
    [UIAlertController alertControllerWithTitle:@"Success"
                                        message:@"You have registered a new user"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction =
    [UIAlertAction actionWithTitle:@"ОК"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction* action) {
                               [self openStatisticsView];
                           }];
    [success addAction:okAction];
    [self presentViewController:success animated:YES completion:nil];
}


@end
