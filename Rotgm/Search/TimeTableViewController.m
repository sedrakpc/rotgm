//
//  TimeTableViewController.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 6/29/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "TimeTableViewController.h"
#import "DataManager.h"
#import "RtTime.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController

@synthesize tableBackgroundView;
@synthesize segmentControl;
@synthesize timeTable;
@synthesize backgroundLabel;
@synthesize route;
@synthesize stop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"TIME_TABLE_VC_TITLE", nil);
    [backgroundLabel setText:NSLocalizedString(@"BAS_IS_NOT_AVAILABLE", nil)];
    [segmentControl setTitle:NSLocalizedString(@"TODAY", nil) forSegmentAtIndex:0];
    [segmentControl setTitle:NSLocalizedString(@"TOMORROW", nil) forSegmentAtIndex:1];
    [segmentControl setTitle:NSLocalizedString(@"DAY_OF_WEEK", nil) forSegmentAtIndex:2];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:-5*60*60]];
    NSInteger weekday = [comps weekday] - 1;
    contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    if ([contentList count] == 0) {
        [timeTable setBackgroundView:tableBackgroundView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"stopTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    RtTime *rtTime = [contentList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d:%d", rtTime.hour, rtTime.minute];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return cell;
    
}

#pragma mark - segment controll

- (IBAction)segmentSwitch:(id)sender
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if(segmentControl.selectedSegmentIndex == 0)
    {
        NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:-5*60*60]];
        NSInteger weekday = [comps weekday] - 1;
        contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    }
    else if(segmentControl.selectedSegmentIndex == 1)
    {
        NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:19*60*60]];
        NSInteger weekday = [comps weekday] - 1;
        contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    } else {
        contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:9];
    }
    if ([contentList count] == 0) {
        [timeTable setHidden:YES];
    } else {
        [timeTable setHidden:NO];
    }
    [timeTable reloadData];
    
}

@end
