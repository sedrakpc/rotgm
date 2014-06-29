//
//  TimeTableViewController.m
//  Rotgm
//
//  Created by Sedrak Dalaloyan on 6/29/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import "TimeTableViewController.h"

@interface TimeTableViewController ()

@end

@implementation TimeTableViewController

@synthesize tableBackgroundView;
@synthesize segmentControl;
@synthesize timeTable;
@synthesize backgroundLabel;

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
    [timeTable setBackgroundView:tableBackgroundView];
    [backgroundLabel setText:NSLocalizedString(@"BAS_IS_NOT_AVAILABLE", nil)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
