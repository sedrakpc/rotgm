//
//  TimeTableViewController.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 6/29/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtRoute.h"
#import "RtStop.h"

@interface TimeTableViewController : UIViewController
{
    NSArray *contentList;
}
@property (nonatomic, retain) RtRoute *route;
@property (nonatomic, retain) RtStop *stop;
@property (weak, nonatomic) IBOutlet UILabel *backgroundLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *timeTable;
@property (weak, nonatomic) IBOutlet UIView *tableBackgroundView;
@end
