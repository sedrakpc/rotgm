//
//  DataManager.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 3/4/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
{
    NSMutableArray *data;
}

+ (DataManager*)dataManager;
- (NSArray *)allData;
-(NSArray *)routesList;
-(NSArray *)routeStops:(int)routeId;
-(NSArray *)routesByName:(NSString *)name andType:(NSString *) type;

@end
