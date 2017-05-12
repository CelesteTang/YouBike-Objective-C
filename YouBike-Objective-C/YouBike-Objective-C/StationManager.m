//
//  StationManager.m
//  YouBike-Objective-C
//
//  Created by Chien on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIKit/UIKit.h>
#import "StationManager.h"

@implementation StationManager : NSObject


- (void) getStations {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPRequestHeaders ; // ["Authorization": "\(tokenType) \(token)" ] FB TOKEN
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI ; // parameters -> ["paging": self.nowPageToken] 取下一頁
    
    [manager GET:@"http://52.198.40.72/youbike/v1" parameters:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"失敗");
    }];
}

@end

