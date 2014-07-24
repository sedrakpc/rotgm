//
//  DataManager.h
//  Citybus
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
-(NSArray *)busList;
-(NSArray *)routesFullList;
-(NSArray *)routeStops:(int)routeId;
-(NSArray *)getTimeTable:(int)routeId forStop:(int)stopId dayOfWeek:(NSInteger)dayOfWeek;
-(NSArray *)routesByName:(NSString *)name andType:(NSString *) type;
-(void)insertTimetable:(NSArray*)timeTable;
-(BOOL)isTimeTableExists:(NSString*)type andName:(NSString*)name;

@end
