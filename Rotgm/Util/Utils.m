//
//  Utils.m
//  Citybus
//
//  Created by Sedrak Dalaloyan on 5/10/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSString *) getLocalizedType:(NSString*)type
{
    if([type isEqualToString:@"avto"]) {
        return NSLocalizedString(@"AVTO", nil);
    } else if([type isEqualToString:@"trol"]) {
        return NSLocalizedString(@"TROL", nil);
    } else if([type isEqualToString:@"tram"]) {
        return NSLocalizedString(@"TRAM", nil);
    }
    return nil;
}
@end
