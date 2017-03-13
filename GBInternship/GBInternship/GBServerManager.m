//
//  GBServerManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBServerManager.h"
#import "AFNetworking.h"

#warning Here must be infinitive link to fetch data
static NSString* originLink = @"http://www._______________";

@interface GBServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) NSURL* tempUrl;

@end

@implementation GBServerManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {

#warning Here we can change link or add another ending
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"____/rest", originLink]];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
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









@end
