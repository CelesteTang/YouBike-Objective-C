//
//  Station.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@implementation Station

- (id)initWithName:(NSString*)name Address:(NSString*)address NumberOfRemainingBikes:(NSString*)numberOfRemainingBikes Latitude:(NSNumber*)latitude Longitude:(NSNumber*)longitude
{
    self = [super init];
    if(self) {
        self.address = address;
        self.name = name;
        self.numberOfRemainingBikes = numberOfRemainingBikes;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

+(instancetype) getStationWithDictFromServer: (NSDictionary *) dict {
    
    Station *station = [Station alloc];
    
    NSString *name = dict[@"sna"];
    NSString *address = dict[@"ar"];
    NSString* numberOfRemainingBikes = dict[@"bemp"];
    NSNumber* latitude = dict[@"lat"];
    NSNumber* longitude = dict[@"lng"];
    
    station = [station initWithName:name Address:address NumberOfRemainingBikes:numberOfRemainingBikes Latitude:latitude Longitude:longitude];
    
    return station;
}

@end

