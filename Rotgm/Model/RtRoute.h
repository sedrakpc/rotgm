//
//  RtRoute.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 5/5/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RtStop.h"

@interface RtRoute : NSObject
@property (nonatomic, assign) int routeId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) RtStop *from;
@property (nonatomic, strong) RtStop *to;
@property (nonatomic, copy) NSString *days;
@end
