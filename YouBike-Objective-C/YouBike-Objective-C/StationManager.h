//
//  StationManager.h
//  YouBike-Objective-C
//
//  Created by Chien on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NetworkHandler.h"

#ifndef StationManager_h
#define StationManager_h

#endif /* StationManager_h */

@interface StationManager : NSObject <NetWorkHandlerDelegate>

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *tokenType;

+(instancetype) sharedInstance;
-(void) getStationsWithFacebookToken: (NSString *) token;
-(void) didGetDataFromServer: (NSData *) data;
-(void) failToGetDataFromeServer;
-(void) didGetServerAccessToken: (NSData *) data;

@end
