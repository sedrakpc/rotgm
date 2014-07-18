//
//  RtBus.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 7/16/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtBus : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, strong) NSArray *routes;
@end
