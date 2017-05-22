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
    
    NSMutableArray *stations;
}

@synthesize delegate;

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
        networkHandler.delegate = self;
        stations = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) getStationsWithFacebookToken: (NSString *) token{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
    
        [networkHandler getServerAccessTokenWith: token];
    });
}

-(void) getStationsWithServerTokenType: (NSString*)tokenType andToken: (NSString*) token {
    
    [networkHandler getStationsWithToken:[[tokenType stringByAppendingString:@" "] stringByAppendingString:token]];
}

-(void) didGetServerAccessToken: (NSData *) data {
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    NSDictionary *dataDict = JSON[@"data"];
    NSString *tokenType = dataDict[@"tokenType"];
    NSString *token = dataDict[@"token"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:tokenType forKey:@"tokenType"];
    [userDefault setObject:token forKey:@"token"];

    [networkHandler getStationsWithToken:[[tokenType stringByAppendingString:@" "] stringByAppendingString:token]];
}

-(void) didGetDataFromServer: (NSData *) data {
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    NSArray *dataArray = JSON[@"data"];
    
    
    for (int i = 0; i < dataArray.count; i++) {
        
        NSDictionary *dict = dataArray[i];
        Station* station = [Station getStationWithDictFromServer:dict];
        [stations addObject:station];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [delegate didGetStationFromServer];
    });
}

-(void) failToGetDataFromeServer {
    
}

-(NSInteger) numberOfRowsInSection: (NSInteger) index {
    
    //NSLog(@"======numberOfRow %lu===========", (unsigned long)stations.count);
    
    return stations.count;
}

-(Station *) getStationsWith: (NSInteger) section andRow: (NSInteger) row {
 
    if (row >= stations.count) {
        
        //NSLog(@"========out of range count: %lu======row %lu=====", (unsigned long)stations.count, (unsigned long)row);
        return stations[0];
    }
    
    //NSLog(@"========section %lu======row %lu=====", (unsigned long)section, (unsigned long)row);
    return stations[row];
}

-(NSDictionary*) dataToJSON: (NSData*) data {

    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];

    return dataDict;
}

@end
