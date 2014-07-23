//
//  SearchViewController.m
//  Citybus
//
//  Created by Sedrak Dalaloyan on 2/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "SearchViewController.h"
#import "Constants.h"
#import "RtRoute.h"
#import "DataManager.h"
#import "DirectionViewController.h"
#import "RtBus.h"
#import "StopViewController.h"
#import "RouteButton.h"
#import "Utils.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize searchBar;
@synthesize serachTableView;
@synthesize searchBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sections = @[@"avto", @"trol", @"tram" ];
        cellColors = @[ UIColorFromRGB(0x00AA00), UIColorFromRGB(0x0095FF), UIColorFromRGB(0xFF5043) ];
        NSArray *allList = [[DataManager dataManager] busList];
        NSMutableArray *busList = [[NSMutableArray alloc] init];
        NSMutableArray *tramList = [[NSMutableArray alloc] init];
        NSMutableArray *trolList = [[NSMutableArray alloc] init];
        for (RtBus *bus in allList) {
            if ([bus.type caseInsensitiveCompare:sections[0]] == NSOrderedSame) {
                [busList addObject:bus];
            } else if ([bus.type caseInsensitiveCompare:sections[1]] == NSOrderedSame) {
                [trolList addObject:bus];
            }  else if ([bus.type caseInsensitiveCompare:sections[2]] == NSOrderedSame) {
                [tramList addObject:bus];
            }
        }
        contentList = @[ busList, trolList, tramList];
        filteredContentList = [[NSMutableArray alloc] initWithArray:contentList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"SEARCH_VC_TITLE", nil);
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //[self setAutomaticallyAdjustsScrollViewInsets:YES];
    //[self setExtendedLayoutIncludesOpaqueBars:YES];
    
    //searchBar.barTintColor = [UIColor orangeColor];
    //searchBar.tintColor = [UIColor greenColor];
    //[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isSearching) {
        return [filteredContentList[section] count];
    }
    else {
        return [contentList[section] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"searchTableCell";
    
    UITableViewCell *cell = [serachTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];

    }
    
    // Configure the cell...
    RtBus *bus;
    if (isSearching) {
        bus = [filteredContentList[indexPath.section] objectAtIndex:indexPath.row];
    }
    else {
        bus = [contentList[indexPath.section] objectAtIndex:indexPath.row];
    }
    UILabel *nameText = (UILabel *)[cell viewWithTag:1];
    nameText.text = bus.name;
    nameText.textColor = cellColors[indexPath.section];
    UILabel *daysText = (UILabel *)[cell viewWithTag:4];
    daysText.text = [self daysText:bus.days];
    if ([bus.routes count] > 0) {
        UILabel *topLabel = (UILabel *)[cell viewWithTag:2];
        RtRoute *rtRout = bus.routes[0];
        NSString *text = [NSString stringWithFormat:@"%@ - %@", [rtRout.from.name length] == 0 ? @"" : rtRout.from.name, [rtRout.to.name length] == 0 ? @"" : rtRout.to.name];
        topLabel.text = text;
        RouteButton *topButton = (RouteButton *)[cell viewWithTag:5];
        topButton.route = rtRout;
        [topButton addTarget:self action:@selector(switchToRoute:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([bus.routes count] > 1) {
        UILabel *bottomLabel = (UILabel *)[cell viewWithTag:3];
        RtRoute *rtRout = bus.routes[1];
        NSString *text = [NSString stringWithFormat:@"%@ - %@", [rtRout.from.name length] == 0 ? @"" : rtRout.from.name, [rtRout.to.name length] == 0 ? @"" : rtRout.to.name];
        bottomLabel.text = text;
        RouteButton *bottomButton = (RouteButton *)[cell viewWithTag:6];
        bottomButton.route = rtRout;
        [bottomButton addTarget:self action:@selector(switchToRoute:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"   %@", [Utils getLocalizedTypePlural:sections[section]] ];
}

- (IBAction) switchToRoute:(id)sender {
    RouteButton *buttonClicked = (RouteButton *)sender;
    StopViewController  *stopVC = [[StopViewController alloc] initWithNibName:@"StopViewController" bundle:nil];
    stopVC.route = buttonClicked.route;
    [self.navigationController pushViewController:stopVC animated:YES];
}

- (NSString *)daysText:(NSString *)days {
    NSArray *daysArray = [days componentsSeparatedByString:@","];
    NSMutableString *daysBinaryMask = [[NSMutableString alloc] init];
    for (int i = 0; i < 7; i++) {
        BOOL found = false;
        for (int j = 0; j < [daysArray count]; j++) {
            if ([[[daysArray objectAtIndex:j] substringWithRange:NSMakeRange(i, 1)] compare:@"1"] == NSOrderedSame) {
                [daysBinaryMask appendString:@"1"];
                found = true;
                break;
            }
        }
        if(found) continue;
        [daysBinaryMask appendString:@"0"];
    }
    NSArray *weekdays = [NSLocalizedString(@"WEEKDAYS_ARRAY", nil) componentsSeparatedByString:@","];
    
    if ([daysBinaryMask compare:@"1111111"] == NSOrderedSame) {
        return NSLocalizedString(@"EVERY_DAY", nil);
    }
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [weekdays count]; i++) {
        if ([[daysBinaryMask substringWithRange:NSMakeRange(i, 1)] compare:@"1"] == NSOrderedSame) {
            [result appendString:weekdays[i]];
            [result appendString:@", "];
        }
    }
    if ([result length] > 0) {
        [result deleteCharactersInRange:NSMakeRange([result length]-2, 1)];
    }
    return result;
}

- (void)searchTableList {
    NSString *searchString = searchBar.text;
    
    [filteredContentList removeAllObjects];
    NSMutableArray *busList = [[NSMutableArray alloc] init];
    NSMutableArray *tramList = [[NSMutableArray alloc] init];
    NSMutableArray *trolList = [[NSMutableArray alloc] init];
    [filteredContentList addObjectsFromArray:@[ busList, trolList, tramList]];
    for (int i = 0; i < [contentList count]; ++i) {
        for (RtBus *tempBus in contentList[i]) {
            NSComparisonResult result = [tempBus.name compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
            if (result == NSOrderedSame) {
                [filteredContentList[i] addObject:tempBus];
            }
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RtBus *bus;
    if (isSearching) {
        bus = [filteredContentList[indexPath.section] objectAtIndex:indexPath.row];
    }
    else {
        bus = [contentList[indexPath.section] objectAtIndex:indexPath.row];
    }
    DirectionViewController  *directionVC = [[DirectionViewController alloc] initWithNibName:@"DirectionViewController" bundle:nil];
    directionVC.bus = bus;
    [self.navigationController pushViewController:directionVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.serachTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isSearching = NO;
    [self.serachTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchTableList];
}

@end
