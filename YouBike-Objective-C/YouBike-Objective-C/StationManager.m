//
//  StationManager.m
//  YouBike-Objective-C
//
//  Created by Chien on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//
#import "StationManager.h"

@implementation StationManager {

    NetworkHandler *networkHandler;
}

+ (instancetype) sharedInstance
{
    static StationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[StationManager alloc] init];
    });
    return instance;
}

-(instancetype) init {
    
    self = [super init];
    
    if (self) {
        networkHandler = [[NetworkHandler alloc] init];
        [networkHandler setDelegate:self];
    }
    
    return self;
}

-(void) getStationsWithFacebookToken: (NSString *) token{

    [networkHandler getServerAccessTokenWith: token];
}

-(void) didGetServerAccessToken: (NSData *) data {
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    NSDictionary *dataDict = JSON[@"data"];
    NSString *tokenType = dataDict[@"tokenType"];
    NSString *token = dataDict[@"token"];
    NSLog(@"=====tokentype========");
    NSLog(@"%@", tokenType);
    
    [networkHandler getStationsWithToken:[[tokenType stringByAppendingString:@" "] stringByAppendingString:token]];
}

-(void) didGetDataFromServer: (NSData *) data {
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    
    NSLog(@"=================");
    NSLog(@"%@", JSON);
}

-(void) failToGetDataFromeServer {
    
}

-(NSDictionary*) dataToJSON: (NSData*) data {

    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];

    return dataDict;
}
@end
