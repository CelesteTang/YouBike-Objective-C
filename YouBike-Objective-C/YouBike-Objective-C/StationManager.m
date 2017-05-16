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

-(void) didGetServerAccessToken: (NSData *) data {
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    NSDictionary *dataDict = JSON[@"data"];
    NSString *tokenType = dataDict[@"tokenType"];
    NSString *token = dataDict[@"token"];

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
    
    return stations.count;
}

-(Station *) getStationsWith: (NSInteger) section andRow: (NSInteger) row {
 
    return stations[row];
}

-(NSDictionary*) dataToJSON: (NSData*) data {

    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];

    return dataDict;
}

@end
