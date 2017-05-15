//
//  Station.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station: NSObject

@property NSString *name;
@property NSString *address;
@property NSNumber *numberOfRemainingBikes;
@property NSNumber *latitude;
@property NSNumber *longitude;

- (id)initWithName:(NSString*)name Address:(NSString*)address NumberOfRemainingBikes:(NSNumber*)numberOfRemainingBikes Latitude:(NSNumber*)latitude Longitude:(NSNumber*)longitude;

+(instancetype) getStationWithDictFromServer: (NSDictionary *) dict;

@end
