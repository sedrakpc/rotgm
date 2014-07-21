//
//  RtTime.h
//  Citybus
//
//  Created by Sedrak Dalaloyan on 7/3/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtTime : NSObject
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
- (NSComparisonResult)compare:(RtTime *)otherObject;
@end
