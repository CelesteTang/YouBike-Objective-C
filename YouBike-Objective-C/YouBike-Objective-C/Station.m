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

- (id)initWithName:(NSString*)name Address:(NSString*)address NumberOfRemainingBikes:(int)numberOfRemainingBikes Latitude:(double)latitude Longitude:(double)longitude
{
    self = [super init];
    if(self) {
        NSLog(@"_init: %@", self);
        self.address = address;
        self.name = name;
        self.numberOfRemainingBikes = numberOfRemainingBikes;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

@end

