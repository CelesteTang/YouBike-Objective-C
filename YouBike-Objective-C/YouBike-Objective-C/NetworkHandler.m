//
//  NetworkHandler.m
//  YouBike-Objective-C
//
//  Created by WU CHIH WEI on 2017/5/15.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "NetworkHandler.h"

@implementation NetworkHandler {
    
    NSString *baseURL;
}

@synthesize delegate;

-(instancetype) init {
    
    self = [super init];
    
    if (self) {
        baseURL = @"http://52.198.40.72/youbike/v1";
    }
    
    return self;
}

-(void) getServerAccessTokenWith: (NSString *) token {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:token,@"accessToken", nil];
    
    [self requestToServer:signin withMethod:post andDict:dict andHeaderValue:@"application/json" andHeader:ContentType compeltionHandler: ^void(NSData* data){
        
        [delegate didGetServerAccessToken: data];
    }];
}

-(void) getStationsWithToken: (NSString *) token {
    
    [self requestToServer:stations withMethod:get andDict:nil andHeaderValue:token andHeader:Authorization compeltionHandler: ^void(NSData* data){
        
        [delegate didGetDataFromServer: data];
    }];
}

-(void) requestToServer:(EndPoint)endPoint withMethod:(Method) method andDict: (NSDictionary *) body andHeaderValue: (NSString *) headerValue andHeader: (Header) header compeltionHandler: (void(^)(NSData*)) completion {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSString *endPointString = [self endPointEnumToString:endPoint];
    NSURL *url = [NSURL URLWithString: [baseURL stringByAppendingString:endPointString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    if (url) {
        
        [request setURL:url];
        [request setHTTPMethod: [self methodEnumToString:method]];
        [request setValue:headerValue  forHTTPHeaderField:[self headerEnumToString:header]];
        
        if (body != nil) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
            [request setHTTPBody:data];
        }
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data,NSURLResponse *response,NSError *error){
            
            if (error != nil) {
                
                NSLog(@"============error=============");
                NSLog(@"%@", error);
                
                return;
            }

            completion(data);
        }];
        
        [task resume];
    }
}

-(NSString *) endPointEnumToString: (EndPoint) endPoint {
    
    NSArray *array = [[NSArray alloc] initWithObjects:endPointArray, nil];
    
    return [array objectAtIndex:(endPoint - 1)];
}

//TODO
-(EndPoint) endPointStringToEnum: (NSString *) strVal {
    
    NSArray *array = [[NSArray alloc] initWithObjects:endPointArray, nil];
    
    NSUInteger n = [array indexOfObject:strVal];
    
    if (n == NSNotFound) {
        
        return 0;
    }
    
    return (EndPoint) n;
}

-(NSString *) methodEnumToString: (Method) method {
    
    NSArray *array = [[NSArray alloc] initWithObjects:methodArray, nil];
    
    return [array objectAtIndex:(method - 1)];
}

-(NSString *) headerEnumToString: (Header) header {
    
    NSArray *array = [[NSArray alloc] initWithObjects:headerArray, nil];
    
    return [array objectAtIndex:(header - 1)];
}

@end
