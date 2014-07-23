//
//  RtTime.m
//  Citybus
//
//  Created by Sedrak Dalaloyan on 7/3/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "RtTime.h"

@implementation RtTime
@synthesize hour;
@synthesize minute;
- (NSComparisonResult)compare:(RtTime *)otherObject {
    int selfHour = self.hour;
    int otherHour = otherObject.hour;
    if(selfHour >= 0 && selfHour < 5) {
        selfHour+=30;
    }
    if(otherHour >= 0 && otherHour < 5) {
        otherHour+=30;
    }
    if (selfHour == otherHour) {
        if (self.minute < otherObject.minute)
            return NSOrderedAscending;
        else if (self.minute > otherObject.minute)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }
    if (selfHour < otherHour)
        return NSOrderedAscending;
    else if (selfHour > otherHour)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}
@end
