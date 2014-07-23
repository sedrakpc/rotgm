//
//  TimeTableViewController.m
//  Citybus
//
//  Created by Sedrak Dalaloyan on 6/29/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "TimeTableViewController.h"
#import "DataManager.h"
#import "RtTime.h"
#import "Utils.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController

@synthesize segmentControl;
@synthesize timeTable;
@synthesize backgroundLabel;
@synthesize route;
@synthesize stop;
@synthesize headerLabel;
@synthesize subHeaderLabel;
@synthesize dayPickerView;
@synthesize pickerViewTextField;

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
    self.title = stop.name;//NSLocalizedString(@"TIME_TABLE_VC_TITLE", nil);
    headerLabel.text = [NSString stringWithFormat:@"%@ №%@", [Utils getLocalizedType:route.type], route.name];
    NSString *text = [NSString stringWithFormat:@"%@ - %@", [route.from.name length] == 0 ? @"" : route.from.name, [route.to.name length] == 0 ? @"" : route.to.name];
    subHeaderLabel.text = text;
    [backgroundLabel setText:NSLocalizedString(@"BAS_IS_NOT_AVAILABLE", nil)];
    [segmentControl setTitle:NSLocalizedString(@"TODAY", nil) forSegmentAtIndex:0];
    [segmentControl setTitle:NSLocalizedString(@"TOMORROW", nil) forSegmentAtIndex:1];
    [segmentControl setTitle:NSLocalizedString(@"DAY_OF_WEEK", nil) forSegmentAtIndex:2];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:-5*60*60]];
    NSInteger weekday = [comps weekday] - 1;
    contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableData)
                                                 name:@"reloadTableData"
                                               object:nil];
    
    pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pickerViewTextField];
    dayPickerView.showsSelectionIndicator = YES;
    pickerViewTextField.inputView = dayPickerView;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    //UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    pickerViewTextField.inputAccessoryView = toolBar;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *weekdays = [dateFormatter weekdaySymbols];
    NSUInteger firstWeekdayIndex = [[NSCalendar currentCalendar] firstWeekday] - 1;
    if (firstWeekdayIndex > 0)
    {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7-firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0,firstWeekdayIndex)]];
    }
    pickerViewDataSource = weekdays;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollToCurrentTIme];
}

- (void) scrollToCurrentTIme
{
    if ([contentList count] > 0) {
        NSDate* currentDate = [NSDate date];
        unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:unitFlags fromDate:currentDate];
        RtTime* currentTime = [[RtTime alloc] init];
        currentTime.hour = (int)comps.hour;
        currentTime.minute = (int)comps.minute;
        int i = 0;
        for (i = 0; i < [contentList count]; i++) {
            RtTime* rtTime = [contentList objectAtIndex:i];
            if ([currentTime compare:rtTime] == NSOrderedAscending) {
                break;
            }
        }
        int scrollTo = i > 2 ? i - 2 : i;
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:scrollTo inSection:0];
        [timeTable scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    static NSString *CellIdentifier = @"timeTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TimeTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    UILabel *labelText = (UILabel *)[cell viewWithTag:1];
    RtTime *rtTime = [contentList objectAtIndex:indexPath.row];
    labelText.text = [NSString stringWithFormat:@"%d:%02d", rtTime.hour, rtTime.minute];
    if(segmentControl.selectedSegmentIndex == 0) {
        labelText.textColor = [self getDateColor:rtTime];
    }
    return cell;
}

- (UIColor *) getDateColor:(RtTime *)time {
    NSDate* currentDate = [NSDate date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:currentDate];
    if (time.hour < 5 && time.hour >= 0 && comps.hour >= 5 && comps.hour <= 23) {
        comps.day = comps.day + 1;
    }
    if(comps.hour < 5 && comps.hour >= 0 && time.hour >= 5 && time.hour <= 23)
    {
        comps.day = comps.day - 1;
    }
    comps.hour   = time.hour;
    comps.minute = time.minute;
    if([currentDate compare:[calendar dateFromComponents:comps]] == NSOrderedDescending) {
        return [UIColor lightGrayColor];
    } else {
        return [UIColor blackColor];
    }
}

- (void)cancelTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [pickerViewTextField resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [pickerViewTextField resignFirstResponder];
    
    // perform some action
    NSString *selectedDayOfWeek = [pickerViewDataSource objectAtIndex:[dayPickerView selectedRowInComponent:0]];
    [segmentControl setTitle:selectedDayOfWeek forSegmentAtIndex:segmentControl.selectedSegmentIndex];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEEE";
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[dateFormatter dateFromString:selectedDayOfWeek]];
    NSInteger weekday = [comps weekday] - 1;
    contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"reloadTableData"
     object:self];
}

-(void)reloadTableData{
    [timeTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    /*[[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        [timeTable reloadData];
        NSIndexSet * sections = [NSIndexSet indexSetWithIndex:0];
        [timeTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
    }];*/
}

#pragma mark - segment controll

- (IBAction)segmentSwitch:(id)sender
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    if(segmentControl.selectedSegmentIndex == 0)
    {
        [self cancelTouched:nil];
        NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:-5*60*60]];
        NSInteger weekday = [comps weekday] - 1;
        contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    }
    else if(segmentControl.selectedSegmentIndex == 1)
    {
        [self cancelTouched:nil];
        NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[[NSDate date] dateByAddingTimeInterval:19*60*60]];
        NSInteger weekday = [comps weekday] - 1;
        contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:weekday];
    } else {
        [pickerViewTextField becomeFirstResponder];
        //contentList = [[DataManager dataManager] getTimeTable:route.routeId forStop:stop.stopId dayOfWeek:9];
    }
    if ([contentList count] == 0) {
        [timeTable setHidden:YES];
    } else {
        [timeTable setHidden:NO];
    }
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"reloadTableData"
     object:self];
    if(segmentControl.selectedSegmentIndex == 0)
    {
        [self scrollToCurrentTIme];
    }
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerViewDataSource count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerViewDataSource objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // perform some action
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
