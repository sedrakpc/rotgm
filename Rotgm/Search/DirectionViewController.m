//
//  DirectionViewController.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 5/10/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "DirectionViewController.h"
#import "Utils.h"
#import "DataManager.h"

@interface DirectionViewController ()

@end

@implementation DirectionViewController

@synthesize route;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@ №%@", [Utils getLocalizedType:route.type], route.name];
    contentList = [[DataManager dataManager] routesByName:route.name andType:route.type];
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
    static NSString *CellIdentifier = @"searchTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    RtRoute *rtRout = [contentList objectAtIndex:indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%@ - %@", [rtRout.from.name length] == 0 ? @"" : rtRout.from.name, [rtRout.to.name length] == 0 ? @"" : rtRout.to.name];
    cell.textLabel.text = text;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return cell;
    
}

@end
