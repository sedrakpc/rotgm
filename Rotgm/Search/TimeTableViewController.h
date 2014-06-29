//
//  TimeTableViewController.h
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 6/29/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *backgroundLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UITableView *timeTable;
@property (weak, nonatomic) IBOutlet UIView *tableBackgroundView;
@end
