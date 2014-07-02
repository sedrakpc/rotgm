//
//  DataManager.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 3/4/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "DataManager.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "RtRoute.h"
#import "RtTime.h"
#import <CommonCrypto/CommonDigest.h>

@interface DataManager()
    @property (nonatomic, strong) FMDatabase *db;
@end

@implementation DataManager

static DataManager *manager;

@synthesize db;

+ (DataManager*) dataManager {
    if (manager == nil) {
        manager = [[DataManager alloc] init];
    }
    return manager;
}

-(id) init
{
    if (self = [super init])
    {
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"rotgm" ofType:@"sqlite"];
        //NSFileManager *fileMng = [NSFileManager defaultManager];
        
        db = [FMDatabase databaseWithPath:dbPath];
        if (![db open]) {
            #ifdef DEBUG
            NSLog(@"Could not open db.");
            #endif
            return 0;
        }    }
    
    return self;
}

-(NSArray *)allData
{
    return data;
}

-(NSArray *)routesList
{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:@"SELECT DISTINCT [type], [name] from rt_route;"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    while ([rs next]) {
        RtRoute *route = [[RtRoute alloc] init];
        route.type = [rs stringForColumnIndex:0];
        route.name = [rs stringForColumnIndex:1];
        [result addObject:route];
    }
    [rs close];
    return result;
}

-(NSArray *)routesFullList
{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:@"SELECT DISTINCT [type], [name] from rt_route;"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    while ([rs next]) {
        RtRoute *route = [[RtRoute alloc] init];
        route.type = [rs stringForColumnIndex:0];
        route.name = [rs stringForColumnIndex:1];
        [result addObject:route];
    }
    [rs close];
    return result;
}

-(NSArray *)routesByName:(NSString *)name andType:(NSString *) type
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:@"SELECT rt.id, rt.type, rt.name, rt.[from], from_st.name, rt.[to], to_st.name from rt_route as rt inner join rt_stop as from_st on rt.[from] = from_st.id inner join rt_stop as to_st on rt.[to] = to_st.id where rt.name = ? and rt.type = ?", name, type];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    while ([rs next]) {
        RtRoute *route = [[RtRoute alloc] init];
        route.routeId = [rs intForColumnIndex:0];
        route.type = [rs stringForColumnIndex:1];
        route.name = [rs stringForColumnIndex:2];
        RtStop *from = [[RtStop alloc] init];
        from.stopId = [rs intForColumnIndex:3];
        from.name = [rs stringForColumnIndex:4];
        route.from = from;
        RtStop *to = [[RtStop alloc] init];
        to.stopId = [rs intForColumnIndex:5];
        to.name = [rs stringForColumnIndex:6];
        route.to = to;
        [result addObject:route];
    }
    [rs close];
    return result;
}



-(NSArray *)getTimeTable:(int)routeId forStop:(int)stopId dayOfWeek:(NSInteger)dayOfWeek
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:@"select [route], [stop], [dates], [hour], [minute] from rt_time_table where route = ? AND stop = ? AND SUBSTR(dates, ?, 1) = \"1\"", [NSNumber numberWithInt:routeId], [NSNumber numberWithInt:stopId], [NSNumber numberWithInteger:dayOfWeek]];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    while ([rs next]) {
        RtTime *rtTime = [[RtTime alloc] init];
        rtTime.hour = [rs intForColumnIndex:3];
        rtTime.minute = [rs intForColumnIndex:4];
        [result addObject:rtTime];
    }
    [rs close];
    return result;
}

-(NSArray *)routeStops:(int)routeId {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:@"select rtrs.[route], rtrs.[stop], st.[name], rtrs.[waypoint] from rt_route_stop as rtrs inner join rt_stop as st on rtrs.[stop] = st.[id] where rtrs.[route] = ? order by rtrs.waypoint asc", [NSNumber numberWithInt:routeId]];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    while ([rs next]) {
        RtStop *stop = [[RtStop alloc] init];
        stop.stopId = [rs intForColumnIndex:1];
        stop.name = [rs stringForColumnIndex:2];
        [result addObject:stop];
    }
    [rs close];
    return result;
}

@end
