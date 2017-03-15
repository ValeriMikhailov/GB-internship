//
//  GBServerManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBServerManager.h"
#import "AFNetworking.h"

static NSString* originLink = @"http://52.89.213.205:8090/rest/user/";

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

#pragma mark - Help methods -

- (void) calculatingFetchDuration {
    
    //Calculating how long the data wasn't update
}









@end
