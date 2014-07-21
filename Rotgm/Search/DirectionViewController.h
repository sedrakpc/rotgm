//
//  DirectionViewController.h
//  Citybus
//
//  Created by Sedrak Dalaloyan on 5/10/14.
//  Copyright (c) 2014 sedrakpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtRoute.h"
#import "RtBus.h"

@interface DirectionViewController : UIViewController
{
    NSArray *contentList;
}
@property (nonatomic, strong) RtBus *bus;
@property (weak, nonatomic) IBOutlet UITableView *directionTableView;
@end
