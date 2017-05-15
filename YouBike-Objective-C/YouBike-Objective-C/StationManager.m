//
//  StationManager.m
//  YouBike-Objective-C
//
//  Created by Chien on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationManager.h"
#define endPointArray @"/sign-in/facebook", nil
#define methodArray @"GET", @"POST", nil

@implementation StationManager {
    
    NSString *baseURL;
}

typedef enum {
    
    singin = 1
    
} EndPoint;

typedef enum {
    
    get = 1,
    post
    
} Method;

-(instancetype) init {
    
    self = [super init];
    
    if (self) {
        baseURL = @"http://52.198.40.72/youbike/v1";
    }
    
    return self;
}

-(void) getStationsWithFacebookToken: (NSString *) token {
    
    EndPoint endPoint = singin;
    
    Method method = post;
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:token,@"accessToken", nil];
    
    [self requestToServer:endPoint withMethod:method andDict:dict];
}

-(void) requestToServer:(EndPoint)endPoint withMethod:(Method) method andDict: (NSDictionary *) body {
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSString *endPointString = [self endPointEnumToString:endPoint];
    NSURL *url = [NSURL URLWithString: [baseURL stringByAppendingString:endPointString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    if (url) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
        
        [request setURL:url];
        [request setHTTPMethod: [self methodEnumToString:method]];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data,NSURLResponse *response,NSError *error){
            
            if (error != nil) {
                
                NSLog(@"============error=============");
                NSLog(@"%@", error);
                
                return;
            }
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
            NSLog(@"=========dataDict===========");
            NSLog(@"%@", dataDict);
            
            NSDictionary *content = dataDict[@"data"];
            NSLog(@"==========content==========");
            NSLog(@"%@", content);
            
            NSString *tokenType = content[@"tokenType"];
            NSLog(@"===========tokenType=========");
            NSLog(@"%@", tokenType);
            
            NSString *token = content[@"token"];
            NSLog(@"==========token==========");
            NSLog(@"%@", token);
            
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

@end
