//
//  StationManager.h
//  YouBike-Objective-C
//
//  Created by Chien on 2017/5/12.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#ifndef StationManager_h
#define StationManager_h

#endif /* StationManager_h */

@interface StationManager : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *tokenType;

-(void) getStationsWithFacebookToken: (NSString *) token;
@end
