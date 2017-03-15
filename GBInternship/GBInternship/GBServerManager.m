//
//  GBServerManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBServerManager.h"
#import "AFNetworking.h"

static NSString* originLink = @"http://52.89.213.205:8080/rest/user/";

@interface GBServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) NSURL* tempUrl;

@end

@implementation GBServerManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:originLink]];
    }
    
    return self;
}

+ (GBServerManager*) sharedManager {
    
    static GBServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        manager = [[GBServerManager alloc] init];
    });
    
    return manager;
}

#pragma mark - API methods - 

//  Array with name and rank by siteID
- (void) getArrayBySiteID: (NSInteger) category
                onSuccess: (void(^)(NSArray* productsArray)) success
                onFailure: (void(^)(NSError* error)) failure {
    
    NSString* link = [NSString stringWithFormat:@"%@%ld", originLink, (long)category];
    
    [self.sessionManager GET:link
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask * task, id responseObject) {
                         
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         NSMutableArray* array = (NSMutableArray*)responseObject;
                         
                         for (NSUInteger i = 0; i < array.count; i++) {
                             
                             NSDictionary* singleProduct = array[i];
                             
                             NSLog(@"новый жсон: %@", singleProduct);
                             
                         }
                         
                         if (success) {
                             
                             success(objectsArray);
                         }
                         
                     } failure:^(NSURLSessionDataTask* task, NSError* error) {
                         NSLog(@"Error: %@", error);
                         if (failure) {
                             failure(error);
                         }
                     }];
    
}


#pragma mark - Help methods -

- (void) calculatingFetchDuration {
    
    //Calculating how long the data wasn't update
}









@end
