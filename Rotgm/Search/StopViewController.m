//
//  StopViewController.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 6/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "StopViewController.h"
#import "Utils.h"
#import "DataManager.h"
#import "TimeTableViewController.h"

@interface StopViewController ()

@end

@implementation StopViewController

@synthesize route;

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
    self.title = NSLocalizedString(@"STOP_VC_TITLE", nil);
    contentList = [[DataManager dataManager] routeStops:route.routeId];
    // Do any additional setup after loading the view from its nib.
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
    RtStop *rtStop = [contentList objectAtIndex:indexPath.row];
    cell.textLabel.text = rtStop.name;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RtStop *selectedStop = [contentList objectAtIndex:indexPath.row];
    TimeTableViewController  *ttVC = [[TimeTableViewController alloc] initWithNibName:@"TimeTableViewController" bundle:nil];
    ttVC.route = route;
    ttVC.stop = selectedStop;
    [self.navigationController pushViewController:ttVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
