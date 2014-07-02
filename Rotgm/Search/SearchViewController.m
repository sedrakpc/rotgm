//
//  SearchViewController.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 2/21/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "SearchViewController.h"
#import "Constants.h"
#import "RtRoute.h"
#import "DataManager.h"
#import "DirectionViewController.h"

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
        contentList = [[DataManager dataManager] routesList];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isSearching) {
        return [filteredContentList count];
    }
    else {
        return [contentList count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"searchTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];

    }
    
    // Configure the cell...
    RtRoute *route;
    if (isSearching) {
        route = [filteredContentList objectAtIndex:indexPath.row];
    }
    else {
        route = [contentList objectAtIndex:indexPath.row];
    }
    UILabel *nameText = (UILabel *)[cell viewWithTag:1];
    nameText.text = route.name;
    return cell;
    
}

- (void)searchTableList {
    NSString *searchString = searchBar.text;
    
    for (RtRoute *tempRoute in contentList) {
        NSComparisonResult result = [tempRoute.name compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempRoute];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RtRoute *route;
    if (isSearching) {
        route = [filteredContentList objectAtIndex:indexPath.row];
    }
    else {
        route = [contentList objectAtIndex:indexPath.row];
    }
    DirectionViewController  *directionVC = [[DirectionViewController alloc] initWithNibName:@"DirectionViewController" bundle:nil];
    directionVC.route = route;
    [self.navigationController pushViewController:directionVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
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
