//
//  NetworkHandler.h
//  YouBike-Objective-C
//
//  Created by WU CHIH WEI on 2017/5/15.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define endPointArray @"/sign-in/facebook",@"/stations", @"/stations?paging=", nil
#define methodArray @"GET", @"POST", nil
#define headerArray @"Authorization", @"Content-Type", nil

@protocol NetWorkHandlerDelegate
-(void) didGetServerAccessToken: (NSData *) data;
-(void) didGetDataFromServer: (NSData *) data;
-(void) failToGetDataFromeServer;
@end

@interface NetworkHandler : NSObject

@property(weak, atomic, readwrite) id <NetWorkHandlerDelegate> delegate;

typedef enum {
    
    signin = 1,
    stations,
    paging
    
} EndPoint;

typedef enum {
    
    get = 1,
    post
    
} Method;

typedef enum {
    
    Authorization = 1,
    ContentType
    
} Header;

-(void) getServerAccessTokenWith: (NSString *) token;
-(void) getStationsWithToken: (NSString *) token andPaging: (NSString*) pagingString;

@end

