//
//  GBServerManager.m
//  GBInternship
//
//  Created by Stanly Shiyanovskiy on 13.03.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

#import "GBServerManager.h"
#import "AFNetworking.h"
#import "GBSites.h"
#import "GBPerson.h"

static NSString* originLink = @"https://52.89.213.205:8443/rest/user/";

@interface GBServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) NSURL* tempUrl;

@end

@implementation GBServerManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:originLink]];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        self.sessionManager.securityPolicy.validatesDomainName = NO;
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"user@gmail.com" password:@"user"];
        [self.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
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

//  Array with siteID, it's name (URL) and startDate statistic
/* Example how to use this method:
 
 [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *productsArray) {
 
 NSLog(@"**********************");
 for (id obj in productsArray) {
 
 NSLog(@"%@", obj);
 }
 
 } onFailure:^(NSError *error) {
 
 }];
 
*/
- (void) getArrayOfAvaliableSitesOnSuccess: (void(^)(NSArray* sitesArray)) success
                                 onFailure: (void(^)(NSError* error)) failure {
    
    NSString* link = [NSString stringWithFormat:@"%@sites", originLink];
    
    [self.sessionManager GET:link
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask * task, id responseObject) {
                         
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         NSMutableArray* array = (NSMutableArray*)responseObject;
                         
                         for (NSUInteger i = 0; i < array.count; i++) {
                             
                             NSDictionary* singleProduct = array[i];
                             GBSites* site = [GBSites new];
                             
                             site.siteID = [[singleProduct objectForKey:@"id"] integerValue];
                             site.siteURL = [singleProduct objectForKey:@"name"];
                             
                             [objectsArray addObject:site];
                             
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

//  Array with personID and it's name (URL)

- (void) getArrayOfAvaliablePersonsOnSuccess: (void(^)(NSArray*personsArray)) success
                                 onFailure: (void(^)(NSError* error)) failure {
    
    NSString* link = [NSString stringWithFormat:@"%@persons", originLink];
    
    [self.sessionManager GET:link
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask * task, id responseObject) {
                         
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         NSMutableArray* array = (NSMutableArray*)responseObject;
                         
                         for (NSUInteger i = 0; i < array.count; i++) {
                             
                             NSDictionary* singleProduct = array[i];
                             GBPerson* person = [GBPerson new];
                             
                             person.personID = [[singleProduct objectForKey:@"id"] integerValue];
                             person.personName = [singleProduct objectForKey:@"name"];
                             
                             [objectsArray addObject:person];
                             
                             //NSLog(@"allPersons жсон: %@", singleProduct);
                             
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


//  Array with name and rank by siteID
- (void) getArrayBySiteID: (NSInteger) siteID
                onSuccess: (void(^)(NSArray* statisticArray)) success
                onFailure: (void(^)(NSError* error)) failure {
    
    NSString* link = [NSString stringWithFormat:@"%@%ld", originLink, (long)siteID];
    
    [self.sessionManager GET:link
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask * task, id responseObject) {
                         
                         NSMutableArray* objectsArray = [NSMutableArray array];
                         NSMutableArray* array = (NSMutableArray*)responseObject;
                         
                         for (NSUInteger i = 0; i < array.count; i++) {
                             
                             NSDictionary* singleProduct = array[i];
                             
                             GBPerson* person = [GBPerson new];
                             
                             person.personName = [singleProduct objectForKey:@"personName"];
                             person.personRank = [[singleProduct objectForKey:@"rank"] integerValue];
                             person.startStatDate = [self dateFromString:[singleProduct objectForKey:@"startDate"]];
                             
                             [objectsArray addObject:person];
                             
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

- (NSDate*) dateFromString:(NSString*) string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormatter dateFromString:string];
}











@end
