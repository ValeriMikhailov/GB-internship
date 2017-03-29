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

@interface GBRegistrationViewController ()  <UITextFieldDelegate, NSURLSessionDelegate>

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
    // Try to do it with NSURLSession
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue* queue = [NSOperationQueue mainQueue];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *postDict = @{@"userName": login,
                               @"password": password};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict
                                                       options:0
                                                         error:nil];
    [request setURL:[NSURL URLWithString:@"https://52.89.213.205:8443/rest/user/signup"]];
    [request setHTTPBody:postData];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSURLSessionUploadTask* uploadTask =
            [session uploadTaskWithRequest:request
                                  fromData:postData completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
                                      NSLog(@"%@", uploadTask);
                                      
                                  }];
        } else {
            // error code here
            NSLog(@"%@", error);
        }
        
    }];
    [postDataTask resume];
    
    //NSData* request = [NSData dataWithBytes:[jsonRequest UTF8String]
                                     //length:[jsonRequest length]];
    
    //NSData* request = [NSJSONSerialization dataWithJSONObject:jsonRequest
                                                      //options:NSJSONWritingPrettyPrinted
                                                        //error:nil];
    
//    [man POST:@"https://52.89.213.205:8443/rest/user/signup"
//                   parameters:jsonRequest
//                     progress:nil
//                      success:^(NSURLSessionDataTask* task, id responseObject) {
//                          
//                          NSLog(@"*************************");
//                          
//                      } failure:^(NSURLSessionDataTask* task, NSError* error) {
//                          NSLog(@"%@", error);
//                          NSDictionary* dict = [error userInfo];
//                          NSString* errorStr = [dict objectForKey:@"NSLocalizedDescription"];
//                          
//                          if ([errorStr isEqualToString:@"Request failed: unauthorized (401)"]){
//                              
//                          }
//                      }];

    
    //successfully registered user alert
    //[self successfullyRegisteredAlert];
    

////    NSDictionary* dict = @{@"\"userName\"":[NSString stringWithFormat:@"\"%@\"", login],
////                           @"\"password\"":[NSString stringWithFormat:@"\"%@\"", password]};
//    NSDictionary* dict = @{@"\"userName\"":@"\"stas2@gmail.com\"",
//                           @"\"password\"":@"\"12\""};
//    // Change your 'params' dictionary to JSON string to set it into HTTP
//    // body. Dictionary type will be not understanding by request.
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict
//                                                       options:0
//                                                         error:nil];
//    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    //NSString *jsonString = [NSString stringWithFormat:@"{\"userName\":\"%@\",\"password\":\"%@\"}",login,password];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//
//
//    NSMutableURLRequest *request =
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
//                                                  URLString:@"https://52.89.213.205:8443/rest/user/signup"
//                                                 parameters:nil
//                                                      error:nil];
//    
//    //set headers
//    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    
//    //post  
//    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [[manager dataTaskWithRequest:request
//            completionHandler:^(NSURLResponse* response, id responseObject, NSError* error) {
//        
//        if (!error) {
//            NSLog(@"Reply JSON: %@", responseObject);
//            
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                //blah blah
//            }
//        } else {
//            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
//        }
//    }] resume];
    
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"52.89.213.205"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
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
